FROM centos:7
MAINTAINER Tom Armstrong

RUN yum -y update

RUN yum -y install \
    curl \
    git2u \
    net-tools \
    python34 \
    vim \
    wget \
    rsync

RUN yum -y upgrade && \
    yum clean all    

RUN wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
RUN wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64

RUN chmod +x cfssl_linux-amd64 cfssljson_linux-amd64
RUN mv cfssl_linux-amd64 /usr/local/bin/cfssl
RUN mv cfssljson_linux-amd64 /usr/local/bin/cfssljson

RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.9.0/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

COPY . /var/application

RUN /var/application/install-gcloud.sh


