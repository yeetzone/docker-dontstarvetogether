FROM debian:jessie
MAINTAINER DST Academy <support@dst.academy>

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
	&& curl -o /usr/local/bin/gosu -fsSL "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fsSL "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

ENV STEAM_USER="steam" \
	STEAM_HOME="/opt/steam" \
	DST_HOME="/opt/dst" \
	DSTA_HOME="/usr/local/share/dsta" \
	CLUSTER_PATH="/var/lib/dsta/cluster"

# Add steam user.
RUN adduser --disabled-login --gecos "Steam" --home $STEAM_HOME $STEAM_USER

# Install SteamCMD.
RUN curl -fsSL "https://cdn.steamstatic.com/client/installer/steamcmd_linux.tar.gz" | gosu $STEAM_USER tar -xzvC $STEAM_HOME \
	&& gosu $STEAM_USER $STEAM_HOME/steamcmd.sh \
		+@ShutdownOnFailedCommand 1 \
		+quit \
	&& rm -rf $STEAM_HOME/Steam/logs $STEAM_HOME/Steam/appcache/httpcache \
	&& find $STEAM_HOME/package -type f ! -name "steam_cmd_linux.installed" ! -name "steam_cmd_linux.manifest" -delete

# Install Don't Starve Together Server.
RUN mkdir -p $DST_HOME \
	&& chown $STEAM_USER:$STEAM_USER $DST_HOME \
	&& sync \
	&& gosu $STEAM_USER $STEAM_HOME/steamcmd.sh \
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
	&& chown -R $STEAM_USER:$STEAM_USER $DSTA_HOME \
	&& mkdir -p `dirname $CLUSTER_PATH` \
	&& chown $STEAM_USER:$STEAM_USER `dirname $CLUSTER_PATH`

# Set environment variables.
ENV DESCRIPTION="Powered by DST Academy." \
	SERVER_PORT="10999" \
	MAX_PLAYERS=4 \
	GAME_MODE=survival \
	VOTE_KICK_ENABLE=true \
	PAUSE_WHEN_EMPTY=true \
	SHARD_NAME=shard \
	SHARD_IS_MASTER=false \
	SHARD_BIND_IP="0.0.0.0"

# Expose default server port.
EXPOSE $SERVER_PORT/udp

# Set up a volume for configuration files.
VOLUME ["$CLUSTER_PATH"]

# Set entrypoint and default command.
ENTRYPOINT ["/entrypoint.sh"]
CMD ["dst-server", "start"]
