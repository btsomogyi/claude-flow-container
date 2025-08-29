# Stage 1: Install mise and Node.js
FROM ubuntu:25.04 AS base

# Update package lists and install prerequisites
RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    git-all \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create claudeflow user
RUN useradd -m -s /bin/bash claudeflow && \
    echo 'claudeflow ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to claudeflow user
USER claudeflow
WORKDIR /home/claudeflow

# Install mise-en-place for the claudeflow user
RUN curl https://mise.run | sh

# Add mise to PATH for claudeflow user
ENV PATH="/home/claudeflow/.local/bin:$PATH"

# Initialize mise in the shell profile
RUN echo 'eval "$(mise activate bash)"' >> /home/claudeflow/.bashrc

# Install Node.js version 22 using mise
RUN /home/claudeflow/.local/bin/mise install node@22 && \
    /home/claudeflow/.local/bin/mise global node@22

# Stage 2: Install claude packages
FROM base AS final

# Ensure we're using the claudeflow user
USER claudeflow
WORKDIR /home/claudeflow

# Install claude-code and claude-flow alpha globally
ARG CF_ALPHA_VERSION
RUN echo "$CF_ALPHA_VERSION"
ENV CF_VERSION="2.0.0-alpha.$CF_ALPHA_VERSION"
RUN echo "Installing $CF_VERSION"
ENV PATH="/home/claudeflow/.local/share/mise/shims:${PATH}"
RUN npm install -g @anthropic-ai/claude-code
RUN npm install -g claude-flow@$CF_VERSION

# Default command
CMD ["/bin/bash"]
