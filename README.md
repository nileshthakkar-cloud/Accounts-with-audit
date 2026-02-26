# Dubai B2B Travel Website

Static landing page for a Dubai-based B2B travel agency offering:
- Dubai visa services
- Hotel contracting and bookings
- Holiday packages
- Excursions and transfers

## Create a new repository and push this code

Use the helper script:

```bash
./scripts/push-to-new-repo.sh <new-repo-dir> <remote-url> [branch]
```

Example:

```bash
./scripts/push-to-new-repo.sh ../dubai-b2b-travel-site git@github.com:your-org/dubai-b2b-travel-site.git main
```

What it does:
1. Copies this project into a new directory (without the original `.git` history).
2. Initializes a fresh Git repository.
3. Creates the chosen branch (default: `main`).
4. Commits all project files.
5. Adds `origin` and pushes the branch.
