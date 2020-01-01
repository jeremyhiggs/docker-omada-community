FROM andresvidal/rpi3-mongodb3:latest

# Based on https://github.com/HDebeuf/balena-raspberry-pi4-omada-controller/blob/master/omada/Dockerfile

# Install dependencies
RUN apt-get update && \
    apt-get install -y net-tools curl wget jsvc

# Install java
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk

# Install Omada Controller 3.2.1
# Thanks to the Omada community 
# https://community.tp-link.com/en/business/forum/topic/162210
RUN apt-get install -y ftp
WORKDIR /root
RUN wget https://static.tp-link.com/2019/201909/20190906/Omada_Controller_v3.2.1_linux_x64.tar.gz && \
    tar -zxf Omada_Controller_v3.2.1_linux_x64.tar.gz && \
    sed -i -e 's/JRE_HOME="${OMADA_HOME}\/jre"/JRE_HOME="\/usr\/lib\/jvm\/java-8-openjdk-armhf\/jre"/g' Omada_Controller_v3.2.1_linux_x64/bin/control.sh && \
    sed -i -e 's/JAVA_OPTS="-server/JAVA_OPTS="-client/g' Omada_Controller_v3.2.1_linux_x64/bin/control.sh && \
    sed -i -e 's/${PORTT_TOOL} 127.0.0.1 ${HTTP_PORT} 500/netstat -plnt | grep :::${HTTP_PORT}/g' Omada_Controller_v3.2.1_linux_x64/bin/control.sh && \
    cd Omada_Controller_v3.2.1_linux_x64 && \
    ./install.sh

# Clean files and apt cache
#RUN rm -rf /var/lib/apt/lists/* && \
#  rm md5.txt && \
#  rm get_omada_ftp.sh && \
#  rm omada-controller_3.2.1-1_all.deb

EXPOSE 8088 8043

VOLUME ["/opt/tplink/OmadaController/data","/opt/tplink/OmadaController/work","/opt/tplink/OmadaController/logs"]

#CMD ["omadactl", "-w", "-v", "start"]
CMD "/bin/bash"
