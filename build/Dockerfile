FROM debian:jessie
MAINTAINER Thomas Deinhamer <thasmo@gmail.com>

# Set environment variables.
ENV STORAGE_ROOT="/home/steam/.klei/" \
	CONF_DIR="DoNotStarveTogether" \
	UPDATE_ON_BOOT=true \
	DEFAULT_SERVER_NAME= \
	DEFAULT_SERVER_DESCRIPTION="Powered by DST Academy." \
	SERVER_PORT=10999 \
	OFFLINE_SERVER=false \
	MAX_PLAYERS=4 \
	WHITELIST_SLOTS=0 \
	PVP=false \
	GAME_MODE=survival \
	SERVER_INTENTION=cooperative \
	ENABLE_AUTOSAVER=true \
	TICK_RATE=15 \
	CONNECTION_TIMEOUT=5000 \
	ENABLE_VOTE_KICK=true \
	PAUSE_WHEN_EMPTY=true \
	STEAM_APP_ID=343050 \
	STEAM_AUTHENTICATION_PORT=8766 \
	STEAM_MASTER_SERVER_PORT=27016 \
	STEAM_GROUP_ONLY=false \
	STEAM_GROUP_ADMINS=false \
	CONSOLE_ENABLED=true \
	AUTOCOMPILER_ENABLED=true \
	MODS_ENABLED=true \
	SHARD_ENABLE=false \
	IS_MASTER=false \
	BIND_IP="0.0.0.0" \
	DISABLECLOUD=true

# Install dependencies.
RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends ca-certificates curl lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install gosu.
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# Add steam user.
RUN useradd -m steam

# Add entrypoint script.
COPY /entrypoint.sh /adjectives.txt /names.txt /home/steam/
RUN chmod +x /home/steam/entrypoint.sh

# Install SteamCMD.
RUN cd /home/steam \
	&& curl -SLO "http://media.steampowered.com/installer/steamcmd_linux.tar.gz" \
	&& tar -xvf steamcmd_linux.tar.gz -C /home/steam \
	&& rm steamcmd_linux.tar.gz

# Install Don't Starve Together Server.
RUN /home/steam/steamcmd.sh \
	+@ShutdownOnFailedCommand 1 \
	+@NoPromptForPassword 1 \
	+login anonymous \
	+force_install_dir /home/steam/DoNotStarveTogether \
	+app_update ${STEAM_APP_ID} validate \
	+quit

EXPOSE 10999/udp
VOLUME ["${STORAGE_ROOT}/${CONF_DIR}/save"]

WORKDIR /home/steam/DoNotStarveTogether/data/
ENTRYPOINT ["/home/steam/entrypoint.sh"]
