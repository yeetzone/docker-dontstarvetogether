FROM debian:jessie
MAINTAINER Thomas Deinhamer <thasmo@gmail.com>

# Install dependencies.
RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends ca-certificates curl lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install gosu.
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& curl -o /usr/local/bin/gosu -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# Add steam user.
RUN adduser --disabled-login --gecos "Steam" --home /opt/steam steam

# Install SteamCMD.
COPY /script/steamcmd /usr/local/bin/
RUN curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | gosu steam tar -xzvC /opt/steam/ \
	&& steamcmd \
		+@ShutdownOnFailedCommand 1 \
		+quit

# Install Don't Starve Together Server.
COPY /script/update.sh /usr/local/bin/
RUN mkdir -p /opt/dst/ \
	&& chown steam:steam /opt/dst/ \
	&& sync \
	&& update.sh

# Set environment variables.
ENV UPDATE_ON_BOOT=true \
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

# Copy entrypoint script.
COPY /docker-entrypoint.sh /entrypoint.sh

# Add data files.
COPY /data/ /opt/steam/

EXPOSE 10999/udp
VOLUME ["/opt/steam/dst/"]

WORKDIR /opt/dst/bin/
ENTRYPOINT ["/entrypoint.sh"]
