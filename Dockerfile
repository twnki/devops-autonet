# docker base image for Netmiko, NAPALM, Pyntc, Ansible, and Python3.7

FROM ubuntu:xenial

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y --no-install-recommends \
    install telnet curl openssh-client nano vim iputils-ping python build-essential \
    libssl-dev libffi-dev python-pip python3-pip python-setuptools python3-setuptools \
    python-dev net-tools python3 software-properties-common dnsmasq \
    software-properties-common vim lldpd \ 
    && apt-add-repository -y ppa:ansible/ansible-2.7 \
    && apt-get update && apt-get -y --no-install-recommends install ansible \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update && apt-get -y --no-install-recommends install python3.7 python3.7-venv \
    && rm -rf /var/lib/apt/lists/* \
    && easy_install -U pip \
    && pip install cryptography netmiko napalm pyntc \
    && pip install --upgrade paramiko && mkdir /scripts \
    && mkdir /root/.ssh/ \
    && echo "KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1" > /root/.ssh/config \
    && echo "Ciphers 3des-cbc,blowfish-cbc,aes128-cbc,aes128-ctr,aes256-ctr" >> /root/.ssh/config \
    && chown -R root /root/.ssh/ \
    && python3.7 -m venv /root/venv --copies

VOLUME [ "/root","/usr", "/scripts" ]
CMD [ "sh", "-c", "cd; exec bash -i" ]
