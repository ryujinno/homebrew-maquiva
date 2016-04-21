#!/bin/bash

set -xe

HOMEBREW_URI='https://github.com/Homebrew/brew.git'

PROJECT_DIR=$(cd "${BASH_SOURCE[@]%/*}/.."; echo "${PWD}")

FORMULA_DIR="${PROJECT_DIR}/Formula"
SANDBOX_DIR="${PROJECT_DIR}/build/sandbox"
BREW_CMD="${SANDBOX_DIR}/bin/brew"
CELLAR_DIR="${SANDBOX_DIR}/Cellar"

HOMEBREW_TAP="${TRAVIS_REPO_SLUG/\/homebrew-//}"


get_opt()
{
  if [[ ! -z "${HOMEBREW_TAP}" ]]; then
    OPT_CLEAN='true'
  fi

  for opt in "${@}"; do
    case "${opt}" in
      -c|--clean)
        OPT_CLEAN='true';;
      *)
        FORMULA="${FORMULA} ${opt}";;
    esac
  done

  if [[ -z "${FORMULA}" ]]; then
    FORMULA=$(ls ${FORMULA_DIR}/*.rb)
  fi
}


prepare()
{
  echo 'Prepare homebrew sandbox'
  if [[ -d "${SANDBOX_DIR}" ]]; then
    clean_sandbox
    "${BREW_CMD}" update
  else
    git clone "${HOMEBREW_URI}" "${SANDBOX_DIR}"
  fi
}


clean_sandbox()
{
  if [[ ! -z "${OPT_CLEAN}" ]]; then
    echo 'Clean sandbox'
    cd "${CELLAR_DIR}"
    if ls * > /dev/null 2>&1; then
      "${BREW_CMD}" uninstall *
    fi
    cd -
  fi
}


tap()
{
  if [[ ! -z "${HOMEBREW_TAP}" ]]; then
    echo "Tap ${HOMEBREW_TAP}"
    "${BREW_CMD}" tap "${HOMEBREW_TAP}"
  fi
}


build() {
  echo 'Build formula to sandbox'

  for formula in ${FORMULA}; do
    if [[ -z "${HOMEBREW_TAP}" ]]; then
      pkg="${formula}"
    else
      pkg="${formula##*/}"
      pkg="${HOMEBREW_TAP}/${pkg%.rb}"
    fi

    echo "Build ${pkg}"
    "${BREW_CMD}" install -v "${pkg}"

    clean_sandbox
  done
}

get_opt "${@}"
prepare
tap
build

