# Advanced Git Aliases & Configuration

## Log Formats

Pretty graph log formats for better visualization of history.

### Command Line

```bash
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

### Config Aliases

Add these to your `~/.gitconfig` (or use `git config --global alias.name "value"`).

```ini
[alias]
    # Simple one-line graph with relative date
    lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

    # Detailed graph with absolute date
    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

    # Shortcut to run lg1
    lg = !"git lg1"
```

Usage:

```bash
git lg
git lg -p
```

## Other Useful Commands

Log with graph, decorate, oneline, all branches:

```bash
git log --all --decorate --oneline --graph
```

Show log in reverse order:

```bash
git log --reverse
```
