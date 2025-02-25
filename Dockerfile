FROM ubuntu:14.04.2
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends qemu-system-x86 \
        supervisor qemu-utils wget bridge-utils dnsmasq \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD startup.sh /
ADD noVNC /noVNC/

EXPOSE 5900
EXPOSE 6080

ENV VM_RAM 2048
ENV VM_DISK_IMAGE_SIZE 10G
ENV VM_DISK_IMAGE /data/disk-image
ENV VM_DISK_IMAGE_CREATE_IF_NOT_EXIST 1
ENV ISO http://releases.ubuntu.com/14.04.2/ubuntu-14.04.2-desktop-amd64.iso
ENV ISO_FORCE_DOWNLOAD 0
ENV NETWORK bridge
ENV REMOTE_ACCESS vnc
VOLUME /data
ENTRYPOINT ["/startup.sh"]
