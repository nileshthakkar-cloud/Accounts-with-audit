#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 3 ]]; then
  echo "Usage: $0 <new-repo-dir> <remote-url> [branch]"
  echo "Example: $0 ../dubai-b2b-travel-site git@github.com:your-org/dubai-b2b-travel-site.git main"
  exit 1
fi

NEW_REPO_DIR="$1"
REMOTE_URL="$2"
BRANCH="${3:-main}"

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
git remote add origin "$REMOTE_URL"
git push -u origin "$BRANCH"

echo "✅ New repository created and pushed: $REMOTE_URL ($BRANCH)"
