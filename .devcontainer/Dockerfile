# Reference:
# - https://github.com/theredguild/devcontainer/blob/main/.devcontainer/Dockerfile
# - https://github.com/trailofbits/eth-security-toolbox/blob/master/Dockerfile
# - https://github.com/Deivitto/auditor-docker/blob/main/Dockerfile

###
### Go build stage
###
FROM golang:1.22 AS go-builder

WORKDIR /src
RUN git clone https://github.com/crytic/medusa.git \
    && cd medusa \
    && go build -trimpath -o=/usr/local/bin/medusa -ldflags="-s -w" \
    && chmod 755 /usr/local/bin/medusa

###
### Rust build stage
###
FROM rust as rust-builder

# Install foundry (must be in separate RUNs)
RUN curl -L https://foundry.paradigm.xyz | bash
ENV PATH="/root/.foundry/bin:${PATH}"
RUN foundryup

###
### Devcontainer build stage
###
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Update packages, install pipx and clean up
RUN apt-get update \
    && apt-get install -y pipx \
    && rm -rf /var/lib/apt/lists/*

# Set zsh as the default shell
ENV SHELL=/usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# Set default user, otherwise some commands are not available in the shell
USER vscode

# Include foundry
COPY --from=rust-builder /root/.foundry/bin/* /usr/local/bin/

# Install nvm, yarn, npm, pnpm
RUN curl -o- https://raw.githubusercontent.com/devcontainers/features/main/src/node/install.sh | sudo bash

# Include medusa
COPY --chown=root:root --from=go-builder /usr/local/bin/medusa /usr/local/bin/medusa

# Install slither and python tools
RUN pipx install solc-select \
    && pipx install slither-analyzer \
    && pipx install crytic-compile
