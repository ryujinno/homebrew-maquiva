#!/bin/bash

set -xe

HOMEBREW_URI='https://github.com/Homebrew/brew.git'

cd "${BASH_SOURCE[@]%/*}/.."
PROJECT_DIR="${PWD}"

FORMULA_DIR="${PROJECT_DIR}/Formula"
SANDBOX_DIR="${PROJECT_DIR}/test/sandbox"
BREW_CMD="${SANDBOX_DIR}/bin/brew"
CELLAR_DIR="${SANDBOX_DIR}/Cellar"

echo 'Prepare homebrew sandbox'
if [[ -d "${SANDBOX_DIR}" ]]; then
  "${BREW_CMD}" update
else
  git clone "${HOMEBREW_URI}" "${SANDBOX_DIR}"
fi

echo 'Install formula to sandbox'
for formula in ${FORMULA_DIR}/*.rb; do
  "${BREW_CMD}" install -v "${formula}"
  cd "${CELLAR_DIR}"
  "${BREW_CMD}" uninstall *
done

