# Reference:
# - https://github.com/theredguild/devcontainer/blob/main/.devcontainer/Dockerfile
# - https://github.com/trailofbits/eth-security-toolbox/blob/master/Dockerfile

###
### Medusa build stage
###
FROM golang:1.22 AS medusa

WORKDIR /src
RUN git clone https://github.com/crytic/medusa.git \
    && cd medusa \
    && go build -trimpath -o=/usr/local/bin/medusa -ldflags="-s -w" \
    && chmod 755 /usr/local/bin/medusa

###
### Devcontainer build stage
###
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Update packages, install pipx and clean up
RUN apt-get update \
    && apt-get install -y pipx \
    && sudo apt-get autoremove -y && sudo apt-get clean -y

# Set zsh as the default shell
ENV SHELL=/usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# Set default user, otherwise foundry commands are not available in the shell
USER vscode

# Install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source $HOME/.cargo/env

# Install foundry (must be in separate RUNs)
RUN curl -L https://foundry.paradigm.xyz | zsh
RUN foundryup

# Install nvm, yarn, npm, pnpm
RUN curl -o- https://raw.githubusercontent.com/devcontainers/features/main/src/node/install.sh | sudo bash

# Include medusa
COPY --chown=root:root --from=medusa /usr/local/bin/medusa /usr/local/bin/medusa

# Install slither and python tools
RUN pipx install solc-select \
    && pipx install slither-analyzer \
    && pipx install crytic-compile
