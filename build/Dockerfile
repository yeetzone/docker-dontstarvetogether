FROM debian:jessie
MAINTAINER Thomas Deinhamer <thasmo@gmail.com>

# Install dependencies.
RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		lib32gcc1 \
		lib32stdc++6 \
		libcurl4-gnutls-dev:i386 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install gosu.
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& curl -o /usr/local/bin/gosu -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# Copy setup files.
COPY /script/steamcmd /script/update.sh /usr/local/bin/

# Add steam user.
RUN adduser --disabled-login --gecos "Steam" --home /opt/steam steam

# Install SteamCMD.
RUN curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | gosu steam tar -xzvC /opt/steam/ \
	&& steamcmd \
		+@ShutdownOnFailedCommand 1 \
		+quit

# Install Don't Starve Together Server.
RUN mkdir -p /opt/dst/ \
	&& chown steam:steam /opt/dst/ \
	&& sync \
	&& update.sh

# Install all the needed scripts
COPY /script/* /usr/local/bin/

# Copy entrypoint script.
COPY /docker-entrypoint.sh /entrypoint.sh

# Copy static files.
COPY /static /usr/local/lib/dsta
RUN mkfifo /usr/local/lib/dsta/console \
	&& chown -R steam:steam /usr/local/lib/dsta/ \
	&& mkdir -p /var/lib/dsta/ \
	&& chown steam:steam /var/lib/dsta/

# Set environment variables.
ENV SERVER_DESCRIPTION="Powered by DST Academy." \
	SERVER_PORT=10999 \
	OFFLINE_ENABLE=false \
	MAX_PLAYERS=4 \
	WHITELIST_SLOTS=0 \
	PVP_ENABLE=false \
	GAME_MODE=survival \
	SERVER_INTENTION=cooperative \
	AUTOSAVER_ENABLE=true \
	TICK_RATE=15 \
	CONNECTION_TIMEOUT=5000 \
	VOTE_KICK_ENABLE=true \
	PAUSE_WHEN_EMPTY=true \
	STEAM_AUTHENTICATION_PORT=8766 \
	STEAM_MASTER_SERVER_PORT=27016 \
	STEAM_GROUP_ONLY=false \
	STEAM_GROUP_ADMINS=false \
	CONSOLE_ENABLE=true \
	AUTOCOMPILER_ENABLE=true \
	MODS_ENABLE=true \
	SHARD_ENABLE=false \
	SHARD_IS_MASTER=false \
	SHARD_BIND_IP="0.0.0.0" \
	STEAM_CLOUD_DISABLE=true

# Expose default server port.
EXPOSE 10999/udp

# Set up a volume for configuration files.
VOLUME ["/var/lib/dsta/config"]

# Configure working directory.
WORKDIR /var/lib/dsta/config

# Set entrypoint and default command.
ENTRYPOINT ["/entrypoint.sh"]
CMD ["dst-server", "start"]
