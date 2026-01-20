# NPM Cheatsheet & Best Practices

## Dependency Management & Cleanup

Check for unused or missing dependencies:

```bash
npx depcheck
npx npm-check
```

## Private Registries & Publishing

Login to a private registry:

```bash
npm login --registry=https://registry.example.com/repository/npm-private/
npm whoami --registry=https://registry.example.com/repository/npm-private/
```

Publishing packages:

```bash
# Standard publish
npm publish

# Publish with a specific tag (e.g., beta)
npm publish --tag beta
```

Install a specific tagged version:

```bash
npm install --save my-library@beta
```

## Git Dependencies

Install packages directly from Git repositories:

```json
// package.json example
"dependencies": {
    "my-package": "git+ssh://git@gitlab.com:org/repo.git#tag_or_branch",
    "github-pkg": "git+ssh://git@github.com:username/repo.git#master"
}
```

CLI commands:

```bash
# Install from public GitHub
npm install username/repo --save-dev

# Install from private Git (SSH)
npm install git+ssh://git@gitlab.example.com/group/project.git#branch
```

## Local Development (Linking)

Link a local package for development:

```bash
# In the library directory
npm link

# In the app directory
npm link my-library-name

# To list linked packages
npm ls -g --depth=0
```

## Proxy Configuration

If you seem to have network issues behind a corporate firewall:

```bash
npm config set proxy http://localhost:8081
npm config set https-proxy http://localhost:8081

# To remove
npm config delete http-proxy
npm config delete https-proxy
```

## Package Information

View metadata about packages:

```bash
# View all metadata
npm view package-name

# View dependencies
npm view package-name dependencies

# View versions
npm view package-name versions

# View versions as JSON
npm view package-name versions --json
```

## Angular Specific

Add PWA support:

```bash
ng add @angular/pwa --project project_name
```

Check supported browsers:

```bash
npx browserslist
```
