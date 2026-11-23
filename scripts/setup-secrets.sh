#!/usr/bin/env bash

set -euo pipefail
umask 077

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SECRETS_DIR="${HOME}/.config/secrets"

if [[ -L "${SECRETS_DIR}" ]]; then
  echo "Refusing to write secrets into a symlink: ${SECRETS_DIR}" >&2
  exit 1
fi

mkdir -p "${SECRETS_DIR}"
chmod 700 "${SECRETS_DIR}"

for template in "${BASEDIR}"/secrets.example/*; do
  [[ -f "${template}" ]] || continue
  destination="${SECRETS_DIR}/$(basename "${template}")"

  # Also skip dangling symlinks. Never overwrite existing secrets.
  if [[ -e "${destination}" || -L "${destination}" ]]; then
    continue
  fi

  # noclobber also protects against a file appearing after the check above.
  (set -o noclobber; cat "${template}" > "${destination}")
  chmod 600 "${destination}"
  echo "Created ${destination}; fill it with the secret value."
done
