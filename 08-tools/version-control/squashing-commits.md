# How to Combine Multiple Commits into One for a Clean MR

## Variant 1: Interactive Rebase (BEST) ⭐

```bash
# 1. Check how many commits you need to combine
git log --oneline

# 2. Start interactive rebase (e.g., for last 3 commits)
git rebase -i HEAD~3

# 3. In the editor, change:
pick abc123 First commit
pick def456 Second commit
pick ghi789 Third commit

# To:
pick abc123 First commit
squash def456 Second commit  # or just 's'
squash ghi789 Third commit   # or just 's'

# 4. Save and close the editor
# 5. In the next window, edit the final commit message

# 6. Force push
git push --force-with-lease origin your-branch
```

## Variant 2: Soft Reset (QUICK)

```bash
# 1. Reset N commits but keep the changes
git reset --soft HEAD~3  # for 3 commits

# 2. Create a new commit with all changes
git commit -m "feat(TASK-123): Clean combined commit message"

# 3. Force push
git push --force-with-lease origin your-branch
```

## Variant 3: Squash on Merge (GitHub/GitLab UI)

When creating a PR, simply select **"Squash and merge"** option - all commits will be automatically combined into one during merge.

---

## 📝 When to Use:

- **Interactive rebase** - when you need control (choose which commits to combine)
- **Soft reset** - when you need to quickly combine ALL recent commits
- **Squash merge** - when you don't want to change branch history but want a clean main

## ⚠️ Important Notes:

- Use `--force-with-lease` instead of `--force` (safer)
- Don't rebase public branches (main/master)
- Do this BEFORE code review or warn reviewers

## 🎯 Pro Tips:

1. **Keep atomic commits during development** - easier to track progress
2. **Squash before final review** - cleaner history for reviewers
3. **Write clear commit messages** - they become part of project history
4. **Use conventional commits** - `feat:`, `fix:`, `refactor:`, etc.

## Example Workflow:

```bash
# During development
git commit -m "WIP: add feature X"
git commit -m "WIP: fix bug in X"
git commit -m "WIP: add tests for X"

# Before creating MR
git rebase -i HEAD~3
# Squash all into one clean commit

git commit -m "feat(TASK-123): implement feature X with tests"
git push --force-with-lease origin feature/task-123
```

## Common Issues and Solutions:

### Issue: Merge conflicts during rebase

```bash
# 1. Fix conflicts in files
# 2. Stage resolved files
git add .

# 3. Continue rebase
git rebase --continue

# If you want to abort
git rebase --abort
```

### Issue: Already pushed commits

```bash
# Use force-with-lease (safer than force)
git push --force-with-lease origin your-branch

# This will fail if someone else pushed to the branch
# In that case, coordinate with your team first
```

### Issue: Need to edit specific commit message

```bash
# Use 'reword' instead of 'squash' in interactive rebase
pick abc123 First commit
reword def456 Second commit  # Change message for this one
pick ghi789 Third commit
```

## Real-World Example:

```bash
# You have these commits:
git log --oneline
abc123 fix: typo in README
def456 feat: add user authentication
ghi789 fix: linting errors
jkl012 feat: add login form

# Combine last 4 commits:
git rebase -i HEAD~4

# Editor opens:
pick jkl012 feat: add login form
squash ghi789 fix: linting errors
squash def456 feat: add user authentication
squash abc123 fix: typo in README

# New commit message:
feat(AUTH-123): implement user authentication

- Add login form
- Implement authentication logic
- Fix linting errors
- Update README

# Force push
git push --force-with-lease origin feature/auth-123
```
