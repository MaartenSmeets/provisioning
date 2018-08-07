FROM ubuntu:16.04

MAINTAINER Maarten Smeets <maarten.smeets@amis.nl>

ARG uid

LABEL nl.amis.smeetsm.ide.name="Spring Tool Suite" nl.amis.smeetsm.ide.version="3.9.4"

ADD https://download.springsource.com/release/STS/3.9.4.RELEASE/dist/e4.7/spring-tool-suite-3.9.4.RELEASE-e4.7.3a-linux-gtk-x86_64.tar.gz /tmp/ide.tar.gz

RUN adduser --uid ${uid} --disabled-password --gecos '' develop

RUN mkdir -p /opt/ide && \
    tar zxvf /tmp/ide.tar.gz --strip-components=1 -C /opt/ide && \
    ln -s /usr/lib/jvm/java-8-oracle /opt/ide/sts-3.9.4.RELEASE/jre && \
    chown -R develop:develop /opt/ide && \
    mkdir /home/develop/ws && \
    chown develop:develop /home/develop/ws && \
    rm /tmp/ide.tar.gz && \
    apt-get update && \
    apt-get install -y libxslt1.1 libswt-gtk-3-jni libswt-gtk-3-java && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

USER develop:develop
WORKDIR /home/develop
ENTRYPOINT /opt/ide/sts-3.9.4.RELEASE/STS -data /home/develop/ws
