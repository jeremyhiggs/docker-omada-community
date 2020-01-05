FROM raspbian/jessie

# Install java
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk

# Install mongodb
RUN apt-get update && \
    apt-get install -y mongodb

# Install dependencies for Omada Controller
RUN apt-get update && \
    apt-get install -y net-tools wget jsvc curl

# Install Omada Controller 3.2.4
# Thanks to the Omada community 
# https://community.tp-link.com/en/business/forum/topic/162210
WORKDIR /root
COPY md5.txt md5.txt
RUN wget -q ftp://ftp.rent-a-guru.de/private/omada-controller_3.2.4-1_all.deb && \
    md5sum --check md5.txt && \
    dpkg -i omada-controller_3.2.4-1_all.deb

# Clean files and apt cache
RUN rm -rf /var/lib/apt/lists/* && \
  rm md5.txt && \
  rm omada-controller_3.2.4-1_all.deb

EXPOSE 8088 8043

# TODO check these paths
VOLUME ["/opt/tplink/OmadaController/data","/opt/tplink/OmadaController/work","/opt/tplink/OmadaController/logs"]

#CMD ["omadactl", "-w", "-v", "start"]
CMD "/bin/bash"
