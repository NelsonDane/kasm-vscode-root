FROM kasmweb/vs-code:1.17.0-rolling-weekly@sha256:164a100eae1a986fe35071f2f43492a027f4303508eb9c8b17a5bd89fd3c9114

USER root
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*

USER 1000
