FROM python:2.7-alpine
MAINTAINER Joao P Dubas "joao.dubas@gmail.com"
LABEL version="1.9.6" \
      description="Ansible commands"
ADD http://releases.ansible.com/ansible/ansible-1.9.6.tar.gz /tmp/ansible.tgz
RUN adduser -S -u 1000 alpine \
    && apk update \
    && apk add g++ libffi-dev openssl-dev openssh bash \
    && pip install pycrypto pyyaml jinja2 paramiko \
    && tar -xzf /tmp/ansible.tgz \
    && cd ./ansible-1.9.6 \
    && python ./setup.py install \
    && cd / \
    && rm -rf \
        /tmp/ansible.tgz \
        /tmp/ansible-1.9.6 \
        /root/.cache /var/cache/apk/* \
    && apk del g++
USER alpine
ENTRYPOINT ansible
