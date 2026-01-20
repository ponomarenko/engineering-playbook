# Git LFS (Large File Storage) Guide

Complete guide for working with Git Large File Storage.

## Overview

Git LFS replaces large files with text pointers inside Git, while storing the file contents on a remote server.

## Git LFS Commands

### Check LFS Status
```bash
# Check LFS version
git lfs version

# List LFS tracked files
git lfs ls-files

# Search for specific file in LFS
git lfs ls-files | Select-String filename
```

**Example:**
```bash
git lfs ls-files
# Output:
# 6ec04de324 * src/assets/images/logo.png
# a1b2c3d4e5 * src/assets/video/intro.mp4
```

### Verify File in Git Index
```bash
# List file in index with hash
git ls-files -s path/to/file.ext

# Check object size in Git
git cat-file -s hash-from-above

# View object content (will show LFS pointer)
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

git cat-file blob d356cef18c96c92038972db14735676f99290290
# Output (LFS pointer content):
# version https://git-lfs.github.com/spec/v1
# oid sha256:6ec04de324e0b947eb1826a3eed378b68be40033918d1ec32f2568b67cd2d07c
# size 46234
```

### Get File Hash
```bash
# Get Git hash for a file
git hash-object path/to/file.ext

# This should match the hash in git ls-files if file hasn't changed
```

## Working Without LFS

Sometimes you need to bypass LFS temporarily:

```bash
# Disable LFS temporarily for checkout
$env:GIT_LFS_SKIP_SMUDGE=1
git checkout branch-name

# Clear the variable when done
$env:GIT_LFS_SKIP_SMUDGE=$null

# Checkout with specific filters disabled
git -c filter.lfs.smudge= -c filter.lfs.clean= -c filter.lfs.process= checkout main -- file.png
```

## Troubleshooting LFS Issues

### Files Showing as Changed But Shouldn't

**Problem:** Git shows files as modified even though you didn't change them.

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

### Verify LFS Pointers
```bash
# Check if file is LFS pointer
git cat-file blob hash | Select-String "git-lfs"

# Get actual LFS object hash
git cat-file blob hash | Select-String "sha256"
```

## Environment Variables (PowerShell)

```powershell
# Disable Git LFS temporarily
$env:GIT_LFS_SKIP_SMUDGE=1

# Clear variable
$env:GIT_LFS_SKIP_SMUDGE=$null

# Set editor for Git
$env:GIT_EDITOR="code --wait"  # Use VS Code as editor
```

## Best Practices

1. **Use `.gitattributes`** carefully - understand what filters do
2. **Track binary files early** before they enter regular Git
3. **Verify LFS tracking** with `git lfs ls-files`
4. **Monitor repository size** to ensure LFS is working
5. **Don't mix LFS and non-LFS** for the same file types
6. **Use LFS for files > 100KB** typically (images, videos, binaries)

## Quick Reference

| Task | Command |
|------|---------|
| List LFS files | `git lfs ls-files` |
| Check LFS version | `git lfs version` |
| Check if file is LFS pointer | `git cat-file -s <hash>` (small size = pointer) |
| Disable LFS temporarily | `$env:GIT_LFS_SKIP_SMUDGE=1` |
| View LFS pointer content | `git cat-file blob <hash>` |

---

**Last Updated:** 2026-01-20
