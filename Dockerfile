FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y xfce4 tightvncserver	
RUN \
    echo "Europe/Paris" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="fr_FR.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=fr_FR.UTF-8
RUN \
  apt-get update && \
  apt-get install -y software-properties-common python-software-properties && \
  apt-add-repository ppa:gns3/ppa && \
  apt-get update && \
  apt-get install -y gns3-gui wireshark

COPY xsession /root/.xsession
COPY passwd /root/.vnc/passwd

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]

# Expose ports.
EXPOSE 5901