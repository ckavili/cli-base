FROM registry.access.redhat.com/ubi8/ubi-minimal:8.3

RUN INSTALL_PKGS="git" && \
    microdnf install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    microdnf clean all && \
    YQ_VERSION=3.4.1 && \
    YQ_BINARY=yq_linux_amd64 && \
    curl -X GET https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -L --output /usr/bin/yq && \
    chmod +x /usr/bin/yq && \
    rm -rf /var/log/*
