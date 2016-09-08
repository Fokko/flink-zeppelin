FROM ubuntu:14.04
MAINTAINER Fokko Driesprong <fokko@driesprong.frl>

# Inspired by https://github.com/dylanmei/docker-zeppelin/blob/master/onbuild/Dockerfile

ENV VERSION_JAVA 8u66
ENV VERSION_MAVEN 3.3.9

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y curl net-tools build-essential git wget unzip python python-setuptools libfontconfig npm \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# JAVA
RUN cd /opt/ \
  && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz" \
  && tar xzf jdk-8u66-linux-x64.tar.gz \
  && rm jdk-8u66-linux-x64.tar.gz \
  && update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_66/bin/java 100 \
  && update-alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_66/bin/jar 100 \
  && update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_66/bin/javac 100

# MAVEN
ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/apache-maven-$MAVEN_VERSION
ENV PATH $PATH:$MAVEN_HOME/bin
RUN curl -sL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $MAVEN_HOME /usr/maven

# ZEPPELIN
ENV ZEPPELIN_HOME         /zeppelin
ENV ZEPPELIN_CONF_DIR     $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV ZEPPELIN_PORT         8080

RUN git clone https://github.com/apache/incubator-zeppelin.git $ZEPPELIN_HOME
COPY ./install.sh $ZEPPELIN_HOME/install.sh

# INSTALL & CLEAN
WORKDIR $ZEPPELIN_HOME
COPY ./install.sh install.sh
RUN ./install.sh \
    && rm -rf /root/.m2 \
    && rm -rf /root/.npm

CMD cd $ZEPPELIN_HOME && ./bin/zeppelin.sh
