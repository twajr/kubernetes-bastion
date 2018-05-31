FROM centos:7
MAINTAINER Tom Armstrong

RUN yum -y update

RUN yum -y install \
    bind-utils \
    curl \
    git2u \
    net-tools \
    openssl \
    openssh-server \ 
    openssh-clients \ 
    openssl-libs \
    python34 \
    vim \
    wget \
    rsync \
    tmux

RUN yum -y upgrade && \
    yum clean all    

# Install cfssl 
RUN wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
RUN wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
RUN chmod +x cfssl_linux-amd64 cfssljson_linux-amd64
RUN mv cfssl_linux-amd64 /usr/local/bin/cfssl
RUN mv cfssljson_linux-amd64 /usr/local/bin/cfssljson

# install kubectl
RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

COPY . /var/application

# install google cloud sdk
RUN /var/application/install-gcloud.sh

# install kubeadm
RUN /var/application/install-kubeadm.sh


