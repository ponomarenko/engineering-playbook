# Docker Commands Cheatsheet

## Cleanup Resources

Clean up dangling resources (images, containers, volumes, networks):

```powershell
# Stop all containers
docker stop $(docker ps -a -q)
# Remove all containers
docker rm $(docker ps -a -q)

# PowerShell equivalent
docker ps -q | % { docker stop $_ }
docker ps -q | % { docker rm $_ }

# Prune system (dangling resources)
docker system prune

# Prune EVERYTHING (stopped containers + unused images)
docker system prune -a --volumes
```

## Image Management

Pull specific images:

```bash
docker pull registry.example.com/image:tag
```

Remove all images (PowerShell):

```powershell
$images = docker images -a -q
foreach ($image in $images) { docker image rm $image -f }
```

## Build & Run

Basic build and run cycle:

```bash
# Build
docker build --tag app-name:1.0 .

# Run (detach, publish port, name it)
docker run --publish 8001:8080 --detach --name app-instance app-name:1.0

# Cleanup specific container
docker rm --force app-instance
```

## Container Interaction

Execute commands inside a running container:

```bash
docker exec -it container_name /bin/bash
# OR
docker exec -it container_name bash
```

Copy files:

```bash
# Host to Container
docker cp foo.txt mycontainer:/foo.txt

# Container to Host
docker cp mycontainer:/foo.txt foo.txt

# Directory copy
docker cp src/. mycontainer:/target
```

Logs:

```bash
docker logs -f <CONTAINER_ID>
```

## Registry Login

Login to a private registry:

```bash
docker login registry.example.com
# Prompts for Username and Password
```

## Nginx Alpine Tip

The official Nginx image has many modules. To check installed modules/version:

```bash
docker run --rm nginx:1.16-alpine nginx -V
```
