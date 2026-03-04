default: build

setup:
	@mkdir -p ~/.docker/cli-plugins
	@if ! docker buildx version > /dev/null 2>&1; then \
		echo "Installing docker buildx..."; \
		BUILDX_VERSION=$$(curl -s https://api.github.com/repos/docker/buildx/releases/latest | grep -o '"tag_name": *"[^"]*"' | grep -o 'v[^"]*'); \
		curl -fsSL "https://github.com/docker/buildx/releases/download/$${BUILDX_VERSION}/buildx-$${BUILDX_VERSION}.linux-amd64" \
			-o ~/.docker/cli-plugins/docker-buildx; \
		chmod +x ~/.docker/cli-plugins/docker-buildx; \
		echo "Installed buildx $${BUILDX_VERSION}"; \
	else \
		echo "docker buildx already installed: $$(docker buildx version)"; \
	fi
	docker run --privileged --rm tonistiigi/binfmt --install arm
	docker buildx create --name multiarch --driver docker-container --use 2>/dev/null || docker buildx use multiarch
	docker buildx inspect --bootstrap

build:
	docker buildx build --platform linux/arm/v6 --load -t mapitman/python-arm:latest .

push:
	docker buildx build --platform linux/arm/v6 --push -t mapitman/python-arm:latest .

