#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  $0 <new-repo-dir> <remote-url> [branch]
  $0 <new-repo-dir> --github <owner/repo> [branch] [--public|--private]

Examples:
  $0 ../dubai-b2b-travel-site git@github.com:your-org/dubai-b2b-travel-site.git main
  $0 ../dubai-b2b-travel-site --github your-org/dubai-b2b-travel-site main --private
USAGE
}

if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

NEW_REPO_DIR="$1"
shift

MODE="remote"
REMOTE_URL=""
GITHUB_REPO=""
BRANCH="main"
VISIBILITY="--private"

if [[ "${1:-}" == "--github" ]]; then
  MODE="github"
  GITHUB_REPO="${2:-}"
  if [[ -z "$GITHUB_REPO" ]]; then
    echo "Error: missing <owner/repo> after --github"
    usage
    exit 1
  fi
  shift 2

  if [[ $# -gt 0 && "$1" != --public && "$1" != --private ]]; then
    BRANCH="$1"
    shift
  fi

  if [[ $# -gt 0 ]]; then
    if [[ "$1" == "--public" || "$1" == "--private" ]]; then
      VISIBILITY="$1"
      shift
    else
      echo "Error: unknown option '$1'"
      usage
      exit 1
    fi
  fi

  if [[ $# -gt 0 ]]; then
    echo "Error: too many arguments"
    usage
    exit 1
  fi
else
  REMOTE_URL="$1"
  shift
  if [[ $# -gt 0 ]]; then
    BRANCH="$1"
    shift
  fi
  if [[ $# -gt 0 ]]; then
    echo "Error: too many arguments"
    usage
    exit 1
  fi
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -e "$NEW_REPO_DIR" ]]; then
  echo "Error: destination already exists: $NEW_REPO_DIR"
  exit 1
fi

mkdir -p "$NEW_REPO_DIR"
rsync -a \
  --exclude='.git' \
  --exclude='.DS_Store' \
  "$SOURCE_ROOT/" "$NEW_REPO_DIR/"

cd "$NEW_REPO_DIR"
git init
git checkout -b "$BRANCH"
git add .
git commit -m "Initial commit: Dubai B2B travel website"

if [[ "$MODE" == "github" ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "Error: GitHub mode requires GitHub CLI (gh)."
    exit 1
  fi

  gh repo create "$GITHUB_REPO" "$VISIBILITY" --source=. --remote=origin --push
  echo "✅ New GitHub repository created and pushed: https://github.com/$GITHUB_REPO ($BRANCH)"
else
  git remote add origin "$REMOTE_URL"
  git push -u origin "$BRANCH"
  echo "✅ New repository created and pushed: $REMOTE_URL ($BRANCH)"
fi
