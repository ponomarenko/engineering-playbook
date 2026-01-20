# Git Troubleshooting Cheatsheet

Quick reference for common Git issues and solutions.

## Common Scenarios

### Files Showing as Changed But Shouldn't

**Investigation:**
```bash
# Check what Git thinks changed
git diff file.ext

# Check file in index
git ls-files -s file.ext

# Check actual file hash
git hash-object file.ext

# Compare hashes
git cat-file -s hash-from-ls-files
```

**Solution:**
```bash
# If it's a line ending issue
git config core.autocrlf true  # or false

# If it's Git LFS issue
git restore file.ext
```

### Accidentally Committed Wrong Files

**Solution:**
```bash
# Remove from last commit but keep changes
git reset --soft HEAD~1
git restore --staged unwanted-file.ext
git commit -m "Correct commit message"

# Or amend the commit
git rm --cached unwanted-file.ext
git commit --amend --no-edit
```

### Need to Split/Combine Commits

**Combine last 3 commits:**
```bash
git reset --soft HEAD~3
git commit -m "Combined commit message"
```

**Split last commit:**
```bash
git reset HEAD~1
# Now stage and commit files separately
git add file1.ext
git commit -m "First part"
git add file2.ext
git commit -m "Second part"
```

### Remove Sensitive Files from History

**Warning: This rewrites history!**
```bash
# Remove file from entire history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch path/to/file.ext" \
  --prune-empty --tag-name-filter cat -- --all

# Modern approach with git-filter-repo
git filter-repo --path path/to/file.ext --invert-paths
```

### Lost Commits After Reset

**Recovery using reflog:**
```bash
# See all recent actions
git reflog

# Restore to previous state
git reset --hard HEAD@{2}
```

**Example:**
```bash
git reflog
# Output:
# abc1234 HEAD@{0}: reset: moving to HEAD~1
# def5678 HEAD@{1}: commit: important work (LOST!)
# ghi9012 HEAD@{2}: commit: previous commit

# Recover the lost commit
git reset --hard HEAD@{1}
```

## Quick Command Reference

| Problem | Solution |
|---------|----------|
| Undo last commit (keep changes) | `git reset --soft HEAD~1` |
| Undo last commit (discard changes) | `git reset --hard HEAD~1` |
| Unstage file | `git restore --staged file.ext` |
| Discard local changes | `git restore file.ext` |
| Amend last commit | `git commit --amend --no-edit` |
| Combine 3 commits | `git reset --soft HEAD~3` then commit |
| Remove file from Git only | `git rm --cached file.ext` |
| Get file from another branch | `git checkout main -- file.ext` |
| View what would be committed | `git diff --cached` |
| See all recent Git actions | `git reflog` |

## Diagnostic Commands

| What to Check | Command |
|---------------|---------|
| Current status | `git status --short` |
| What changed | `git diff --name-only` |
| Staged changes | `git diff --cached` |
| Recent commits | `git log --oneline -5` |
| File in index | `git ls-files -s file.ext` |
| File hash | `git hash-object file.ext` |
| Object size | `git cat-file -s <hash>` |
| Object content | `git cat-file blob <hash>` |
| Recent actions | `git reflog -10` |

## LFS Troubleshooting

| Issue | Solution |
|-------|----------|
| Check if file is LFS | `git cat-file -s <hash>` (small size = pointer) |
| List LFS files | `git lfs ls-files` |
| Disable LFS temporarily | `$env:GIT_LFS_SKIP_SMUDGE=1` |
| View LFS pointer | `git cat-file blob <hash>` |
| Restore LFS file | `git restore file.ext` |

## Best Practices

1. ✅ **Check status before and after** operations
2. ✅ **Use `--force-with-lease`** instead of `--force`
3. ✅ **Use reflog** to recover from mistakes
4. ✅ **Test on feature branches** first
5. ✅ **Never rebase shared branches**
6. ✅ **Commit early, squash before PR**
7. ✅ **Write clear commit messages**
8. ✅ **Review with `git diff`** before committing
9. ✅ **Keep backups** before complex operations
10. ✅ **Understand filters** in `.gitattributes`

## Emergency Recovery

```bash
# If you're lost, start here:

# 1. See what Git knows
git status

# 2. See recent history
git reflog -10

# 3. See what would be lost
git diff HEAD

# 4. Create safety backup
git branch backup-$(date +%Y%m%d)

# 5. Then proceed with fixes
```

## PowerShell Helpers

```powershell
# Check file sizes
(Get-Item "file.ext").Length

# Filter git output
git status --short | Select-String "\.png"

# Calculate hash
certutil -hashfile "file.ext" SHA256

# Total size of files
Get-ChildItem -Recurse *.png | Measure-Object -Property Length -Sum
```

---

**Last Updated:** 2026-01-20
