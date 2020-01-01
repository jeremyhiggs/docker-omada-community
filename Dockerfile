FROM andresvidal/rpi3-mongodb3:latest

# Based on https://github.com/HDebeuf/balena-raspberry-pi4-omada-controller/blob/master/omada/Dockerfile

# Install dependencies
RUN apt-get update && \
    apt-get install -y net-tools curl wget jsvc

# Install java
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk

# Install Omada Controller 3.2.4
# Thanks to the Omada community 
# https://community.tp-link.com/en/business/forum/topic/162210
RUN apt-get install -y ftp
COPY get_omada_ftp.sh get_omada_ftp.sh
COPY md5.txt md5.txt
RUN ./get_omada_ftp.sh && \
  md5sum --check md5.txt && \
  dpkg -i omada-controller_3.2.4-1_all.deb

# Clean files and apt cache
RUN rm -rf /var/lib/apt/lists/* && \
  rm md5.txt && \
  rm get_omada_ftp.sh && \
  rm omada-controller_3.2.4-1_all.deb

EXPOSE 8088 8043

VOLUME ["/opt/tplink/OmadaController/data","/opt/tplink/OmadaController/work","/opt/tplink/OmadaController/logs"]

CMD ["omadactl", "-w", "-v", "start"]
