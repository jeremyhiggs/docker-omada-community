FROM stretch-slim:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y net-tools curl

# Set up repository for Oracle JRE 8
# https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-debian-9
RUN apt install software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    add-apt-repository ppa:webupd8team/java
# Install java
RUN apt-get update && \
    apt-get install -y jsvc oracle-java8-installer
RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre/bin/java
