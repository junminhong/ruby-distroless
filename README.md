# Ruby Distroless
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://github.com/junminhong/ruby-distroless/actions/workflows/build.yml/badge.svg)](https://github.com/junminhong/ruby-distroless/actions)

[繁體中文](README_zh_hant.md)

Ruby Distroless is an open-source project designed to create a minimal and secure Ruby runtime environment using Google's [distroless](https://github.com/GoogleContainerTools/distroless) images.

This project enables you to easily build lightweight Ruby images supporting multiple platforms (e.g., amd64 and arm64) and multiple Ruby versions. It is optimized for production deployments, reducing security risks and minimizing image size.

## Supported Ruby Versions
The supported Ruby versions range from Ruby 2.5 to Ruby 3.4, specifically including:
- Ruby 2.5.9
- Ruby 2.6.10
- Ruby 2.7.8
- Ruby 3.0.7
- Ruby 3.1.6
- Ruby 3.2.7
- Ruby 3.3.7
- Ruby 3.4.2

## Features
- **Minimal and Secure**: Built on distroless images, including only necessary runtime dependencies, avoiding unnecessary tools that may introduce security risks.
- **Multi-Platform Support**: Utilizes Docker Buildx to build images for both amd64 and arm64 architectures.
- **Multiple Ruby Versions**: Supports Ruby versions from 2.5 to 3.4, allowing users to select the appropriate version for their needs.
- **Automated CI/CD**: Integrated with GitHub Actions for automatic builds and deployment to GitHub Container Registry (GHCR).

## Installation
You can pull pre-built images from [GitHub Container Registry (GHCR)](https://ghcr.io). For example, to pull the Ruby 3.3.7 amd64 image:

```bash
# amd64
docker pull ghcr.io/junminhong/ruby-distroless:3.3.7-amd64
# arm65
docker pull ghcr.io/junminhong/ruby-distroless:3.3.7-arm64
```

## Usage
You can run Ruby directly using this image:

```bash
# amd64
docker run --rm ghcr.io/junminhong/ruby-distroless:3.3.7-amd64 ruby -v
# arm65
docker run --rm ghcr.io/junminhong/ruby-distroless:3.3.7-arm64 ruby -v
```

This will display the Ruby version. If you need to run other Ruby programs inside the container, refer to Docker's [CMD instruction](https://docs.docker.com/engine/reference/builder/#cmd).

## Building the Image
You can use the provided `Dockerfile` and `build.sh` script to build images manually.

### Dockerfile
The Dockerfile utilizes multi-stage builds, extracting Ruby binaries and dependencies from the official Ruby slim image and copying them into a minimal distroless image. See [Dockerfile](./Dockerfile) for details.

### build.sh
The `build.sh` script automates the process of building multiple Ruby versions.

1. Grant execution permissions:
   ```bash
   chmod +x build.sh
   ```
2. Set the platform environment variable for ARM builds:
   ```bash
   export PLATFORM=linux/arm64
   ```
3. Enable pushing to the remote registry (optional):
   ```bash
   export PUSH_IMAGE=true
   ```
4. Run the script:
   ```bash
   ./build.sh
   ```

## GitHub Actions
This project uses GitHub Actions to automatically build multi-platform and multi-version Ruby images and push them to GitHub Container Registry (GHCR).

For more details, see [`.github/workflows/build.yml`](./.github/workflows/build.yml). The workflow triggers automatic builds whenever you push to the `main` branch or create a pull request.

## Contributing
We welcome contributions in all forms! If you have ideas, bug reports, or feature enhancements, feel free to open an issue or submit a pull request.

### Contribution Guidelines
1. Fork this repository.
2. Create a new branch and make modifications.
3. Submit a pull request with detailed descriptions of your changes.
4. We will review and respond to your PR as soon as possible.

## License
This project is licensed under the [MIT License](LICENSE.md). See the [LICENSE](LICENSE.md) file for details.

## Contact
- GitHub: [junminhong](https://github.com/junminhong)
- If you have any questions or suggestions, feel free to open an issue or submit a pull request.
