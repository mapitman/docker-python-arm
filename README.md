# docker-python-arm

A Docker image based on `arm32v6/alpine` with a Python 3 environment and common packages pre-installed:

- `python3`
- `py3-pip`
- `py3-numpy`
- `py3-pillow`
- `py3-psutil`
- `py3-yaml`
- `py3-paho-mqtt`

## Prerequisites

- Docker (with the `buildx` plugin — included in Docker Desktop and Docker Engine 19.03+)
- A Linux/macOS host (Windows with WSL2 also works)

## First-time setup

Because this image targets `linux/arm/v6`, cross-platform build support must be enabled on your host before building. Run **once**:

```bash
make setup
```

This will:

1. Download and install the `docker buildx` CLI plugin if not already present
2. Install QEMU ARM emulation handlers via `tonistiigi/binfmt`
3. Create (or switch to) a `buildx` builder instance named `multiarch` that supports multi-platform builds
4. Bootstrap and verify the builder is ready

> **Note:** The `make setup` step requires a privileged container to install the QEMU binary formats. You only need to run it once per machine (or after a Docker restart that clears binfmt registrations).

## Building the image

```bash
make build
```

This builds the image for `linux/arm/v6` and loads it into your local Docker image store.

## Pushing the image

```bash
make push
```

This builds and pushes the image directly to Docker Hub as `mapitman/python-arm:latest`. You must be logged in (`docker login`) with push access to that repository.

## Makefile targets

| Target  | Description                                              |
|---------|----------------------------------------------------------|
| `setup` | Install QEMU binfmt handlers and configure buildx        |
| `build` | Cross-compile the image and load it locally              |
| `push`  | Cross-compile the image and push it to Docker Hub        |
