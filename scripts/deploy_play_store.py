"""Build and upload signed Android App Bundles (.aab) to Google Play Console."""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Any

from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaFileUpload

SCOPES = ["https://www.googleapis.com/auth/androidpublisher"]
DEFAULT_PACKAGE_NAME = "com.jgmedellin.coolmorning"
DEFAULT_AAB_PATH = Path("build/app/outputs/bundle/release/app-release.aab")
LOCAL_CONFIG_PATH = Path("scripts/deploy.local.json")


def find_repo_root() -> Path:
    """Return the repository root directory (parent of scripts/)."""
    return Path(__file__).resolve().parent.parent


def load_local_config(repo_root: Path) -> dict[str, Any]:
    """Load optional untracked local config from scripts/deploy.local.json."""
    config_file = repo_root / LOCAL_CONFIG_PATH
    if not config_file.exists():
        return {}
    return json.loads(config_file.read_text(encoding="utf-8"))


def resolve_key_file(cli_key_file: str | None, local_config: dict[str, Any]) -> Path:
    """Resolve the service account JSON key path from CLI, env, or local config."""
    raw = (
        cli_key_file
        or os.environ.get("PLAY_STORE_KEY_FILE")
        or local_config.get("key_file")
    )
    if not raw:
        raise SystemExit(
            "Error: No se especificó el archivo JSON de la Service Account.\n"
            "Usa --key-file, la variable de entorno PLAY_STORE_KEY_FILE, "
            "o configúralo en scripts/deploy.local.json."
        )
    key_path = Path(raw).expanduser()
    if not key_path.is_file():
        raise SystemExit(f"Error: No se encontró el archivo JSON: {key_path}")
    return key_path


def find_flutter_executable(repo_root: Path) -> str:
    """Locate the flutter executable from PATH or android/local.properties."""
    in_path = shutil.which("flutter") or shutil.which("flutter.bat")
    if in_path:
        return in_path

    local_props = repo_root / "android" / "local.properties"
    if local_props.exists():
        for line in local_props.read_text(encoding="utf-8").splitlines():
            if line.startswith("flutter.sdk="):
                sdk_dir = line.split("=", 1)[1].strip().replace("\\\\", "\\")
                candidate = Path(sdk_dir) / "bin" / ("flutter.bat" if os.name == "nt" else "flutter")
                if candidate.is_file():
                    return str(candidate)

    fallback = Path(r"C:\Users\thege\flutter\bin\flutter.bat")
    if fallback.is_file():
        return str(fallback)

    raise SystemExit("Error: No se pudo localizar el ejecutable de Flutter.")


def read_pubspec_version(repo_root: Path) -> str:
    """Read the version string from pubspec.yaml."""
    pubspec = (repo_root / "pubspec.yaml").read_text(encoding="utf-8")
    match = re.search(r"^version:\s*([^\s#]+)", pubspec, flags=re.MULTILINE)
    return match.group(1) if match else "unknown"


def build_aab(repo_root: Path, run_tests: bool) -> Path:
    """Verify signing config, optionally run tests, and build release AAB."""
    key_props = repo_root / "android" / "key.properties"
    if not key_props.is_file() or key_props.stat().st_size == 0:
        raise SystemExit(
            "Error: android/key.properties no existe o está vacío; "
            "no se puede firmar el AAB de release."
        )

    flutter_cmd = find_flutter_executable(repo_root)
    if run_tests:
        print("-> Ejecutando flutter test...")
        subprocess.run([flutter_cmd, "test"], cwd=repo_root, check=True)

    print("-> Compilando AAB de release (flutter build appbundle --release)...")
    subprocess.run(
        [flutter_cmd, "build", "appbundle", "--release"],
        cwd=repo_root,
        check=True,
    )

    aab_path = repo_root / DEFAULT_AAB_PATH
    if not aab_path.is_file():
        raise SystemExit(f"Error: No se generó el AAB esperado en {aab_path}")
    return aab_path


def create_publisher_service(key_file: Path):
    """Create an authenticated Google Play Android Publisher v3 service."""
    credentials = service_account.Credentials.from_service_account_file(
        str(key_file),
        scopes=SCOPES,
    )
    return build("androidpublisher", "v3", credentials=credentials)


def check_connection(service, package_name: str) -> None:
    """Perform a read-only check by opening and discarding a temporary edit."""
    edit = service.edits().insert(body={}, packageName=package_name).execute()
    edit_id = edit["id"]
    try:
        tracks_resp = (
            service.edits()
            .tracks()
            .list(packageName=package_name, editId=edit_id)
            .execute()
        )
        listings_resp = (
            service.edits()
            .listings()
            .list(packageName=package_name, editId=edit_id)
            .execute()
        )
    finally:
        service.edits().delete(packageName=package_name, editId=edit_id).execute()

    languages = [item.get("language") for item in listings_resp.get("listings", [])]
    print(f"Conexión OK con Google Play Console para '{package_name}'.")
    print(f"Idiomas configurados en ficha de Play Store: {languages or ['(ninguno)']}")
    print("Tracks actuales:")
    for track in tracks_resp.get("tracks", []):
        track_name = track.get("track")
        releases = track.get("releases", [])
        if not releases:
            print(f"  - {track_name}: (sin versiones)")
            continue
        for rel in releases:
            print(
                f"  - {track_name}: versionCodes={rel.get('versionCodes')} "
                f"name={rel.get('name')} status={rel.get('status')}"
            )


def upload_aab_and_commit(
    service,
    package_name: str,
    aab_path: Path,
    track: str,
    status: str,
    release_name: str | None,
    release_notes: str | None,
    language: str,
    changes_not_sent_for_review: bool,
) -> None:
    """Upload the signed AAB, assign it to a track, and commit the edit."""
    edit = service.edits().insert(body={}, packageName=package_name).execute()
    edit_id = edit["id"]
    print(f"Edit creado: {edit_id}")

    try:
        media = MediaFileUpload(
            str(aab_path),
            mimetype="application/octet-stream",
            resumable=True,
        )
        print(f"Subiendo AAB: {aab_path} ({aab_path.stat().st_size} bytes)...")
        bundle_resp = (
            service.edits()
            .bundles()
            .upload(
                packageName=package_name,
                editId=edit_id,
                media_body=media,
            )
            .execute()
        )
        version_code = bundle_resp["versionCode"]
        print(f"AAB subido correctamente. versionCode={version_code}")

        release_obj: dict[str, Any] = {
            "versionCodes": [str(version_code)],
            "status": status,
        }
        if release_name:
            release_obj["name"] = release_name
        if release_notes:
            release_obj["releaseNotes"] = [
                {"language": language, "text": release_notes}
            ]

        service.edits().tracks().update(
            packageName=package_name,
            editId=edit_id,
            track=track,
            body={"track": track, "releases": [release_obj]},
        ).execute()
        print(f"Track '{track}' actualizado con status='{status}'.")

        commit_kwargs: dict[str, Any] = {
            "packageName": package_name,
            "editId": edit_id,
        }
        if changes_not_sent_for_review:
            commit_kwargs["changesNotSentForReview"] = True

        commit_resp = service.edits().commit(**commit_kwargs).execute()
        print(f"Release enviado correctamente. Edit confirmado: {commit_resp.get('id')}")
    except Exception:
        try:
            service.edits().delete(packageName=package_name, editId=edit_id).execute()
        except Exception:
            pass
        raise


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Compila y sube el AAB de Cool Morning a Google Play Console."
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Solo verifica credenciales, permisos y tracks actuales (sin subir nada).",
    )
    parser.add_argument(
        "--package-name",
        default=None,
        help=f"Application ID en Play Console (default: {DEFAULT_PACKAGE_NAME}).",
    )
    parser.add_argument(
        "--key-file",
        default=None,
        help="Ruta al archivo JSON de la Service Account.",
    )
    parser.add_argument(
        "--aab",
        default=None,
        help=f"Ruta a un AAB existente (default: {DEFAULT_AAB_PATH}).",
    )
    parser.add_argument(
        "--skip-build",
        action="store_true",
        help="Omite flutter build appbundle --release y usa el AAB existente.",
    )
    parser.add_argument(
        "--skip-tests",
        action="store_true",
        help="Omite flutter test antes de compilar.",
    )
    parser.add_argument(
        "--track",
        default="production",
        choices=["internal", "alpha", "beta", "production"],
        help="Track destino en Google Play (default: production).",
    )
    parser.add_argument(
        "--status",
        default="completed",
        choices=["completed", "draft", "inProgress", "halted"],
        help="Estado del lanzamiento en el track (default: completed).",
    )
    parser.add_argument(
        "--release-name",
        default=None,
        help="Nombre de la versión (default: versión de pubspec.yaml).",
    )
    parser.add_argument(
        "--release-notes",
        default=None,
        help="Notas de la versión (What's new).",
    )
    parser.add_argument(
        "--language",
        default="es-419",
        help="Código de idioma para --release-notes (default: es-419).",
    )
    parser.add_argument(
        "--changes-not-sent-for-review",
        action="store_true",
        help="Guarda cambios sin enviarlos a revisión inmediata.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    repo_root = find_repo_root()
    local_config = load_local_config(repo_root)

    package_name = (
        args.package_name
        or local_config.get("package_name")
        or DEFAULT_PACKAGE_NAME
    )
    key_file = resolve_key_file(args.key_file, local_config)
    service = create_publisher_service(key_file)

    try:
        if args.check:
            check_connection(service, package_name)
            return 0

        if args.skip_build:
            aab_path = Path(args.aab) if args.aab else (repo_root / DEFAULT_AAB_PATH)
            if not aab_path.is_file():
                raise SystemExit(f"Error: No existe el AAB en {aab_path}")
        else:
            aab_path = build_aab(repo_root, run_tests=not args.skip_tests)

        release_name = args.release_name or read_pubspec_version(repo_root).split("+", 1)[0]
        upload_aab_and_commit(
            service=service,
            package_name=package_name,
            aab_path=aab_path,
            track=args.track,
            status=args.status,
            release_name=release_name,
            release_notes=args.release_notes,
            language=args.language,
            changes_not_sent_for_review=args.changes_not_sent_for_review,
        )
        return 0
    except HttpError as exc:
        print(f"Error de Google Play API ({exc.status_code}): {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
