# Stage 1: Install mise and Node.js
FROM ubuntu:25.04 AS base

# Update package lists and install prerequisites
RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install mise-en-place for the root user
RUN curl https://mise.run | sh

# Add mise to PATH for all users
ENV PATH="/root/.local/bin:$PATH"

# Initialize mise in the shell profile
RUN echo 'eval "$(mise activate bash)"' >> /root/.bashrc

# Install Node.js version 22 using mise
RUN /root/.local/bin/mise install node@22 && \
    /root/.local/bin/mise global node@22

# Stage 2: Install claude packages
FROM base AS final

# Install claude-code and claude-flow alpha.89 globally
ENV PATH="/root/.local/share/mise/shims:${PATH}"
RUN npm install -g @anthropic-ai/claude-code
RUN npm install -g claude-flow@alpha

# Set working directory
WORKDIR /root

# Default command
CMD ["/bin/bash"]
