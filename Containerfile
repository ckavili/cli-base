FROM quay.io/openshift/origin-cli:4.6.0

RUN INSTALL_PKGS="git" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    YQ_VERSION=3.4.1 && \
    YQ_BINARY=yq_linux_amd64 && \
    curl -X GET https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY} -L --output /usr/bin/yq && \
    chmod +x /usr/bin/yq
