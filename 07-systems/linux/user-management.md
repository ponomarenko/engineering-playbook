# Linux User Management

## User Identification

Check current user:

```bash
whoami
whoami --version
```

Check logged in users:

```bash
who
w
```

## Managing Users & Groups

Add a new user:

```bash
sudo useradd username
sudo passwd username
```

Add user with home directory and add to groups:

```bash
# -m creates home directory
# --groups adds to specified groups
sudo useradd -m --groups groupname username
```

Check user groups:

```bash
groups username
```

Show current user groups and ID:

```bash
groups
id
```

Delete user:

```bash
sudo userdel username
```

## Process Management

View processes for a specific user:

```bash
ps -u username
```

## Package Management (apt)

Update and install packages (example: strongswan):

```bash
sudo apt-get update
sudo apt-get install -y strongswan network-manager-strongswan libcharon-extra-plugins
```
