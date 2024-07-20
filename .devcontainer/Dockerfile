# Reference:
# - https://github.com/theredguild/devcontainer/blob/main/.devcontainer/Dockerfile
# - https://github.com/trailofbits/eth-security-toolbox/blob/master/Dockerfile

###
### Medusa build stage
###
FROM golang:1.22 AS medusa

WORKDIR /src
RUN git clone https://github.com/crytic/medusa.git
RUN cd medusa && \
    go build -trimpath -o=/usr/local/bin/medusa -ldflags="-s -w" && \
    chmod 755 /usr/local/bin/medusa

###
### Devcontainer build stage
###
FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Update packages
RUN apt-get update

# Install pipx
RUN apt-get install -y pipx

# Set zsh as the default shell
ENV SHELL=/usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# Include medusa
COPY --chown=root:root --from=medusa /usr/local/bin/medusa /usr/local/bin/medusa

# Install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source $HOME/.cargo/env

# Install nvm, yarn, npm, pnpm
RUN curl -o- https://raw.githubusercontent.com/devcontainers/features/main/src/node/install.sh | sudo bash

# Install slither and python tools
RUN pipx install solc-select
RUN pipx install slither-analyzer
RUN pipx install crytic-compile

# Install foundry
RUN curl -L https://foundry.paradigm.xyz | zsh
RUN foundryup

# Clean up
RUN sudo apt-get autoremove -y && sudo apt-get clean -y
