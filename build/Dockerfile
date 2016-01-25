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

ENV STEAM_HOME="/opt/steam" \
	DST_HOME="/opt/dst" \
	DSTA_HOME="/usr/local/lib/dsta" \
	CONFIG_PATH="/var/lib/dsta/config"

# Add steam user.
RUN adduser --disabled-login --gecos "Steam" --home $STEAM_HOME steam

# Install SteamCMD.
RUN curl -fsSL "https://cdn.steamstatic.com/client/installer/steamcmd_linux.tar.gz" | gosu steam tar -xzvC $STEAM_HOME \
	&& gosu steam $STEAM_HOME/steamcmd.sh \
		+@ShutdownOnFailedCommand 1 \
		+quit \
	&& rm -rf $STEAM_HOME/Steam/logs $STEAM_HOME/Steam/appcache/httpcache \
	&& find $STEAM_HOME/package -type f ! -name "steam_cmd_linux.installed" ! -name "steam_cmd_linux.manifest" -delete

# Install Don't Starve Together Server.
RUN mkdir -p $DST_HOME \
	&& chown steam:steam $DST_HOME \
	&& sync \
	&& gosu steam $STEAM_HOME/steamcmd.sh \
		+@ShutdownOnFailedCommand 1 \
		+login anonymous \
		+force_install_dir $DST_HOME \
		+app_update 343050 validate \
		+quit \
	&& rm -rf $STEAM_HOME/Steam/logs $STEAM_HOME/Steam/appcache/httpcache \
	&& find $STEAM_HOME/package -type f ! -name "steam_cmd_linux.installed" ! -name "steam_cmd_linux.manifest" -delete

# Copy common scripts.
COPY /script/* /usr/local/bin/

# Copy entrypoint script.
COPY /docker-entrypoint.sh /entrypoint.sh

# Copy static files.
COPY /static $DSTA_HOME
RUN mkfifo $DSTA_HOME/console \
	&& chown -R steam:steam $DSTA_HOME \
	&& mkdir -p `dirname $CONFIG_PATH` \
	&& chown steam:steam `dirname $CONFIG_PATH`

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
	AUTOCOMPILER_ENABLE=false \
	MODS_ENABLE=true \
	SHARD_ENABLE=false \
	SHARD_IS_MASTER=false \
	SHARD_BIND_IP="0.0.0.0" \
	STEAM_CLOUD_DISABLE=true

# Expose default server port.
EXPOSE 10999/udp

# Set up a volume for configuration files.
VOLUME ["$CONFIG_PATH"]

# Set entrypoint and default command.
ENTRYPOINT ["/entrypoint.sh"]
CMD ["dst-server", "start"]
