# Dubai B2B Travel Website

Static landing page for a Dubai-based B2B travel agency offering:
- Dubai visa services
- Hotel contracting and bookings
- Holiday packages
- Excursions and transfers

## Create a new repository and push this code

### Option A: Existing remote URL

```bash
./scripts/push-to-new-repo.sh <new-repo-dir> <remote-url> [branch]
```

Example:

```bash
./scripts/push-to-new-repo.sh ../dubai-b2b-travel-site git@github.com:your-org/dubai-b2b-travel-site.git main
```

### Option B: Auto-create on GitHub with `gh`

```bash
./scripts/push-to-new-repo.sh <new-repo-dir> --github <owner/repo> [branch] [--public|--private]
```

Examples:

```bash
./scripts/push-to-new-repo.sh ../dubai-b2b-travel-site --github your-org/dubai-b2b-travel-site main --private
./scripts/push-to-new-repo.sh ../dubai-b2b-travel-site --github your-org/dubai-b2b-travel-site --public
```

> Requires GitHub CLI (`gh`) to be installed and authenticated.

## What the script does
1. Copies this project into a new directory (without the original `.git` history).
2. Initializes a fresh Git repository.
3. Creates the chosen branch (default: `main`).
4. Commits all project files.
5. Either:
   - pushes to the provided remote URL, or
   - creates a new GitHub repo via `gh` and pushes.


## Pushing to private GitHub repositories in non-interactive environments

If your environment cannot prompt for username/password, export a Personal Access Token and use the remote-URL mode:

```bash
export GITHUB_TOKEN=<your_token>
./scripts/push-to-new-repo.sh ../dubai-b2b-travel-site https://github.com/OWNER/REPO.git main
```

The script will automatically convert the URL to token-based HTTPS auth when `GITHUB_TOKEN` is set.
