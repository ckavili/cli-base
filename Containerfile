FROM registry.access.redhat.com/ubi8/ubi-minimal:8.3

RUN INSTALL_PKGS="git" && \
    REMOVE_AFTER_BUILD_PKGS="tar" && \
    YQ_VERSION=3.4.1 && \
    OC_VERSION=4.6.3 && \
    CONFTEST_VERSION=0.22.0 && \
    HELM_VERSION=3.3.3 && \
    microdnf install --noplugins --nodocs --assumeyes $INSTALL_PKGS $REMOVE_AFTER_BUILD_PKGS && \
    rpm -V $INSTALL_PKGS $UTIL_PKGS && \
    curl -X GET https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -L --output /usr/bin/yq && \
    chmod +x /usr/bin/yq && \
    curl -X GET https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-linux-${OC_VERSION}.tar.gz --output /usr/bin/oc.tar.gz && \
    tar xvzf /usr/bin/oc.tar.gz -C /usr/bin/ && \
    rm -rf /usr/bin/{oc.tar.gz,README.md,kubectl} && \
    curl -LJO https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    tar xvzf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz -C /usr/bin/ && \
    rm -rf conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x get_helm.sh && \
    ./get_helm.sh --version v${HELM_VERSION} &&  \
    rm get_helm.sh && \
    microdnf remove -y $REMOVE_AFTER_BUILD_PKGS && \
    microdnf clean all && \
    rm -rf /var/log/*
