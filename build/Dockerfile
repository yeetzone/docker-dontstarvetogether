FROM debian:jessie
MAINTAINER Thomas Deinhamer <thasmo@gmail.com>

# Install dependencies.
RUN dpkg --add-architecture i386 \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends ca-certificates curl lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# Add steam user.
RUN adduser --home /var/lib/steam --disabled-login --gecos "Steam" steam

# Install SteamCMD.
RUN gosu steam mkdir -p /var/lib/steam/steamcmd/ \
	&& curl -SL "http://media.steampowered.com/installer/steamcmd_linux.tar.gz" | gosu steam tar -xzvC /var/lib/steam/steamcmd \
	&& chmod 744 /var/lib/steam/steamcmd/steamcmd.sh \
	&& gosu steam /var/lib/steam/steamcmd/steamcmd.sh \
		+@ShutdownOnFailedCommand 1 \
		+quit

# Install Don't Starve Together Server.
COPY /update_dst.sh /var/lib/steam/
RUN chown steam:steam /var/lib/steam/update_dst.sh \
	&& sync \
	&& /var/lib/steam/update_dst.sh

# Add dsta user.
RUN adduser --home /var/lib/dsta --disabled-login --gecos "DST Academy" dsta

# Set environment variables.
ENV UPDATE_ON_BOOT=true \
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

# Add entrypoint script.
COPY /entrypoint.sh /adjectives.txt /names.txt /var/lib/dsta/
RUN chown dsta:dsta -R /var/lib/dsta/

EXPOSE 10999/udp
VOLUME ["/var/lib/dsta/server/DoNotStarveTogether/save"]

WORKDIR /var/lib/steam/DoNotStarveTogether/bin/
ENTRYPOINT ["/var/lib/dsta/entrypoint.sh"]
