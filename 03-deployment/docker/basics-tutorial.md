# Docker Basics Tutorial

## Core Commands ("The Three Chords")

For daily work with Docker, you only need to remember a few key commands.

### 1. Build an Image

To build an image from a `Dockerfile` in the current directory:

```bash
docker build -t your_image_name .
```

> **Note**: The `.` at the end specifies the current directory.

To tag it for a repository:

```bash
docker build -t docker_account/repo_name:tag .
```

You can also tag an existing image:

```bash
docker tag source_image target_image:tag
```

### 2. Push to Registry

Upload your image to a registry (Docker Hub or private):

```bash
docker push docker_account/repo_name:tag
```

_Requires `docker login` first._

### 3. Run a Container

Start an instance of your image:

```bash
docker run -it -p 5000:80 image_name
```

- `-it`: Interactive mode (pseudo-TTY).
- `-p 5000:80`: Map host port 5000 to container port 80.
- Result: Service available at `http://localhost:5000/`.

## Essential Management Commands

| Command              | Description                                |
| :------------------- | :----------------------------------------- |
| `docker ps -a`       | List all containers (running and stopped). |
| `docker rm <name>`   | Remove a stopped container.                |
| `docker logs <name>` | View logs of a container.                  |
| `docker rmi <image>` | Remove an image locally.                   |
