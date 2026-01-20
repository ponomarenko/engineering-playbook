# Git Basics & Essential Commands

Core Git commands for everyday development workflow.

## Checking Repository Status

### Check Current Changes
```bash
# Basic status
git status

# Short format (easier to parse)
git status --short

# Porcelain format (for scripts)
git status --porcelain
```

**Example output:**
```
M  src/app/app.component.ts
A  src/assets/i18n/ru.json
 M src/assets/images/logo.png
```
- `M` = Modified
- `A` = Added
- `D` = Deleted
- Space before letter = unstaged, letter first = staged

### Check Uncommitted Changes
```bash
# See changed files
git diff --name-only

# See detailed changes
git diff

# See staged changes
git diff --cached
```

## Working with Files

### Staging and Unstaging Files
```bash
# Stage specific files
git add file1.ts file2.ts

# Stage all files matching pattern
git add src/**/*.ts

# Unstage files
git restore --staged file.ts

# Unstage all
git restore --staged .
```

### Discarding Changes
```bash
# Discard changes in working directory
git restore file.ts

# Discard all changes
git restore .

# Get file from specific branch/commit
git checkout main -- path/to/file.ext

# Get file from HEAD
git checkout HEAD -- path/to/file.ext
```

**Example scenario:**
```bash
# You modified logo.png but want to revert it
git restore src/assets/images/logo.png

# Or get version from main branch
git checkout main -- src/assets/images/logo.png
```

### Removing Files from Git
```bash
# Remove file from Git but keep locally
git rm --cached file.ext

# Remove multiple files with pattern
git rm --cached src/**/*.png

# Remove directory
git rm -r --cached directory/
```

## Branch Operations

### Switching Branches
```bash
# Switch branches
git checkout branch-name

# Force switch (discard local changes)
git checkout -f branch-name

# Create and switch
git checkout -b new-branch
```

### Stashing Changes
```bash
# Save current changes
git stash

# Save with message
git stash save "Work in progress"

# List stashes
git stash list

# Apply last stash
git stash pop

# Apply specific stash
git stash apply stash@{0}
```

## Viewing History and Changes

### View Commit History
```bash
# Simple one-line format
git log --oneline

# Last N commits
git log --oneline -5

# With graph
git log --oneline --all --graph --decorate

# Search in commits
git log --all --grep="keyword"
```

**Example:**
```bash
git log --oneline -3
# Output:
# abc1234 feat: add user authentication
# def5678 fix: resolve login bug
# ghi9012 refactor: improve code structure
```

### View File History
```bash
# See commits that modified a file
git log --oneline --all --full-history -- path/to/file.ext

# See file content from specific commit
git show commit-hash:path/to/file.ext

# See first 10 lines of file from commit
git show commit-hash:path/to/file.ext | Select-Object -First 10
```

### View Commit Details
```bash
# Full commit details
git show commit-hash

# Statistics only
git show commit-hash --stat

# Name and status of changed files
git show commit-hash --name-status

# Filter by file type
git show commit-hash --stat | Select-String -Pattern "\.png"
```

**Example:**
```bash
git show abc1234 --stat
# Output:
# commit abc1234
# Author: Developer <dev@example.com>
# Date: Mon Jan 20 10:00:00 2026
#
# feat: add authentication
#
# src/auth.ts    | 50 ++++++++++++++++
# src/login.ts   | 30 ++++++++++
```

### Compare Branches
```bash
# See files changed between branches
git diff main --name-only

# See statistics
git diff main --stat

# Specific commit range
git diff commit1..commit2 --name-only
```

## Quick Reference

| Task | Command |
|------|---------|
| Check status | `git status --short` |
| View last 5 commits | `git log --oneline -5` |
| Unstage file | `git restore --staged file.ext` |
| Discard changes | `git restore file.ext` |
| Get file from main | `git checkout main -- file.ext` |
| Remove file from Git | `git rm --cached file.ext` |

---

**Last Updated:** 2026-01-20
