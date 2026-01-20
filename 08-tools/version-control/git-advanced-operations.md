# Git Advanced Operations

Advanced Git techniques for complex workflows and repository management.

## Undoing Changes

### Reset Commits
```bash
# Soft reset - keep changes staged
git reset --soft HEAD~1  # Undo last commit

# Mixed reset - keep changes unstaged (default)
git reset HEAD~1

# Hard reset - discard all changes
git reset --hard HEAD~1

# Reset to specific commit
git reset --hard commit-hash
```

**Example workflow:**
```bash
# You made 3 commits but want to combine them
git reset --soft HEAD~3
# All changes from 3 commits are now staged
git commit -m "Combined commit message"
```

### Amend Last Commit
```bash
# Change commit message
git commit --amend

# Add more changes to last commit
git add forgotten-file.ts
git commit --amend --no-edit

# Change commit message and add changes
git add file.ts
git commit --amend -m "New commit message"
```

### View Reflog (Undo History)
```bash
# See all recent actions
git reflog

# See last 10 actions
git reflog -10

# Restore to previous state
git reset --hard HEAD@{2}
```

**Example:**
```bash
git reflog
# Output:
# abc1234 HEAD@{0}: commit: feat: add feature
# def5678 HEAD@{1}: commit: fix: bug fix
# ghi9012 HEAD@{2}: checkout: moving from main to feature-branch

# Undo last 2 commits
git reset --hard HEAD@{2}
```

## Interactive Rebase

### Rebase Basics
```bash
# Rebase last N commits
git rebase -i HEAD~3

# Rebase to specific commit
git rebase -i commit-hash

# Continue after resolving conflicts
git add .
git rebase --continue

# Abort rebase
git rebase --abort
```

**Example interactive rebase:**
```bash
git rebase -i HEAD~3

# Editor opens:
pick abc1234 First commit
pick def5678 Second commit
pick ghi9012 Third commit

# Change to:
pick abc1234 First commit
squash def5678 Second commit
squash ghi9012 Third commit

# Save and close - all 3 commits combine into one
```

## Force Pushing

### Safe Force Push
```bash
# Safe force push (fails if remote changed)
git push --force-with-lease origin branch-name

# Dangerous force push (overwrites everything)
git push --force origin branch-name
```

**Always prefer `--force-with-lease`!**

## Git Internals

### Check File in Git Index
```bash
# List file in index with hash
git ls-files -s path/to/file.ext

# Check object size in Git
git cat-file -s hash-from-above

# View object content
git cat-file blob hash-from-above
```

**Example:**
```bash
git ls-files -s src/assets/images/logo.png
# Output:
# 100644 d356cef18c96c92038972db14735676f99290290 0  src/assets/images/logo.png

git cat-file -s d356cef18c96c92038972db14735676f99290290
# Output:
# 129  (This indicates it's an LFS pointer, not the actual file!)
```

### Get File Hash
```bash
# Get Git hash for a file
git hash-object path/to/file.ext

# This should match the hash in git ls-files if file hasn't changed
```

## History Rewriting

### Remove Files from All Commits (Sensitive Data)

**Warning: This rewrites history!**
```bash
# Remove file from entire history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file.ext" \
  --prune-empty --tag-name-filter cat -- --all

# Modern approach with git-filter-repo
git filter-repo --path path/to/file.ext --invert-paths
```

## Common Advanced Scenarios

### Combine Last 3 Commits
```bash
git reset --soft HEAD~3
git commit -m "Combined commit message"
```

### Split Last Commit
```bash
git reset HEAD~1
# Now stage and commit files separately
git add file1.ext
git commit -m "First part"
git add file2.ext
git commit -m "Second part"
```

### Accidentally Committed Wrong Files
```bash
# Remove from last commit but keep changes
git reset --soft HEAD~1
git restore --staged unwanted-file.ext
git commit -m "Correct commit message"

# Or amend the commit
git rm --cached unwanted-file.ext
git commit --amend --no-edit
```

## Best Practices

1. **Always use `--force-with-lease`** instead of `--force` when pushing
2. **Use `git reflog`** to recover from mistakes
3. **Test commands on feature branches** before using on main
4. **Never rebase public/shared branches** - only feature branches
5. **Keep backups** of important branches before complex operations
6. **Write clear commit messages** - they're documentation
7. **Review changes** with `git diff` before committing

## Quick Reference

| Task | Command |
|------|---------|
| Undo last commit (keep changes) | `git reset --soft HEAD~1` |
| Undo last commit (discard changes) | `git reset --hard HEAD~1` |
| Amend last commit | `git commit --amend --no-edit` |
| Combine 3 commits | `git reset --soft HEAD~3` then `git commit` |
| Safe force push | `git push --force-with-lease origin branch` |

---

**Last Updated:** 2026-01-20
