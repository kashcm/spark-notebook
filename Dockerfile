FROM debian:latest

MAINTAINER Kash <kasyap.cm@gmail.com>

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    apt-get update && \
    echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections && \
    apt-get -y install oracle-java8-installer && \
    apt-get -y --ignore-missing install wget vim && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /spark

RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-preview-bin-hadoop2.7.tgz -O - | tar -xz
ENV SPARK_HOME /spark/spark-2.0.0-preview-bin-hadoop2.7
ADD startSpark.sh ./
RUN chmod +x /spark/startSpark.sh
CMD ["/spark/startSpark.sh"]

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

WORKDIR /root/.local/share/jupyter/kernels
RUN mkdir pyspark
ADD pyspark ./pyspark

RUN mkdir /usr/work
WORKDIR /usr/work


WORKDIR /spark
ADD startup.sh ./
RUN chmod +x /spark/startup.sh
CMD ["/spark/startup.sh"]

EXPOSE 4040
EXPOSE 7077
EXPOSE 8888
