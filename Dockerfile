FROM ubuntu:14.04
MAINTAINER Thomas Deinhamer <thasmo@gmail.com>

RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y curl lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m steam

COPY /run.sh /home/steam/
RUN chmod +x /home/steam/run.sh

USER steam

RUN mkdir -p /home/steam/.klei/DoNotStarveTogether

RUN cd /home/steam \
	&& curl -SLO "http://media.steampowered.com/installer/steamcmd_linux.tar.gz" \
	&& tar -xvf steamcmd_linux.tar.gz -C /home/steam \
	&& rm steamcmd_linux.tar.gz

RUN /home/steam/steamcmd.sh \
	+@ShutdownOnFailedCommand 1 \
	+@NoPromptForPassword 1 \
	+login anonymous \
	+force_install_dir /home/steam/DoNotStarveTogether \
	+app_update 343050 validate \
	+quit

EXPOSE 10999/udp
VOLUME ["/home/steam/.klei/DoNotStarveTogether"]

WORKDIR /home/steam/DoNotStarveTogether/data/
ENTRYPOINT ["/home/steam/run.sh"]
