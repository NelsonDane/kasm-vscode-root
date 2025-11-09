FROM kasmweb/vs-code:1.17.0-rolling-weekly@sha256:164a100eae1a986fe35071f2f43492a027f4303508eb9c8b17a5bd89fd3c9114

USER root

# Install packages
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    vim \
    ncdu \
    && rm -rf /var/lib/apt/lists/*

# No password sudo for kasm-user
RUN echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Install latest lazygit
RUN set -eux; \
    LAZYGIT_VERSION=$(curl -sL -o /dev/null -w '%{url_effective}' https://github.com/jesseduffield/lazygit/releases/latest | awk -F'/' '{print $NF}' | sed 's/^v//'); \
    curl -fsSL -o lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"; \
    tar -xzf lazygit.tar.gz lazygit; \
    install -m 0755 lazygit /usr/local/bin/lazygit; \
    rm -f lazygit lazygit.tar.gz

# Switch back to non-root user
USER 1000
