# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Architecture Overview

This repository contains a Docker container image that serves as a base "T-Cell" development environment for Claude-Flow projects. The container is built as a multi-stage Docker image with two main components:

1. **Base Stage**: Installs mise (development tool version manager) and Node.js 22
2. **Final Stage**: Adds Claude development tools (@anthropic-ai/claude-code and claude-flow@alpha)

The container uses Ubuntu 25.04 as the base OS and provides a complete development environment with:
- mise for managing multiple language versions
- Node.js 22 as the default JavaScript runtime
- Claude development tools pre-installed globally
- Working directory set to `/root`

## Common Development Commands

### Building the Container
```bash
# Build the Docker image
docker build -t claude-flow-container .

# Build with a specific tag
docker build -t btsomogyi/claude-flow-container:latest .
```

### Running the Container
```bash
# Run interactively with bash
docker run -it claude-flow-container

# Run with volume mount for development
docker run -it -v $(pwd):/workspace claude-flow-container
```

### Publishing the Container
```bash
# Tag for Docker Hub
docker tag claude-flow-container btsomogyi/claude-flow-container:latest

# Push to Docker Hub
docker push btsomogyi/claude-flow-container:latest
```

### Inside the Container
```bash
# Install additional languages using mise
mise install python@3.11
mise install go@1.21

# List available tools
mise ls-remote

# Check installed Claude tools
npm list -g @anthropic-ai/claude-code claude-flow
```

## Container Details

- **Base Image**: Ubuntu 25.04
- **Node.js Version**: 22 (managed by mise)
- **Package Manager**: npm (global installations)
- **Working Directory**: `/root`
- **Published Location**: https://hub.docker.com/repository/docker/btsomogyi/claude-flow-container/general

The container is designed to be a foundation for Claude-Flow development projects, allowing developers to quickly spin up a consistent environment with all necessary tools pre-installed.
