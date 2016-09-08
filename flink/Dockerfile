################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

# Based on: https://raw.githubusercontent.com/apache/flink/master/flink-contrib/docker-flink/Dockerfile

FROM ubuntu:14.04
MAINTAINER Fokko Driesprong <fokko@driesprong.frl>

ENV VERSION_JAVA 8u66
ENV VERSION_MAVEN 3.3.9

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y curl net-tools build-essential git wget unzip curl python python-setuptools libfontconfig npm \
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

# Configure Flink version
ARG FLINK_VERSION=1.1.2
ARG HADOOP_VERSION=27
ARG SCALA_VERSION=2.11

# Flink environment variables
ARG FLINK_INSTALL_PATH=/opt
ENV FLINK_HOME $FLINK_INSTALL_PATH/flink
ENV PATH $PATH:$FLINK_HOME/bin

# Install build dependencies and Flink
RUN set -x && \
  mkdir -p $FLINK_INSTALL_PATH && \
  curl -s $(curl -s https://www.apache.org/dyn/closer.cgi\?preferred\=true)flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-hadoop${HADOOP_VERSION}-scala_${SCALA_VERSION}.tgz | \
  tar xvz -C $FLINK_INSTALL_PATH && \
  ln -s $FLINK_INSTALL_PATH/flink-$FLINK_VERSION $FLINK_HOME && \
  sed -i -e "s/echo \$mypid >> \$pid/echo \$mypid >> \$pid \&\& wait/g" $FLINK_HOME/bin/flink-daemon.sh

# Configure container
ADD docker-entrypoint.sh $FLINK_HOME/bin/
WORKDIR $FLINK_HOME/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh", "-c"]
