FROM dstacademy/dontstarvetogether-base
MAINTAINER DST Academy <support@dst.academy>

# Install gosu.
ENV GOSU_VERSION 1.10
RUN set -ex; \
	\
	fetchDeps=' \
		ca-certificates \
		wget \
	'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu nobody true; \
	\
	apt-get purge -y --auto-remove $fetchDeps

# Set build arguments.
ARG DSTA_HOME
ENV DSTA_HOME ${DSTA_HOME:-"/usr/local/share/dsta"}
ARG CLUSTER_PATH
ENV CLUSTER_PATH ${CLUSTER_PATH:-"/var/lib/dsta/cluster"}
ARG MODS
ENV MODS ${MODS}

# Set environment variables.
ENV DESCRIPTION="Powered by DST Academy." \
	SERVER_PORT="10999" \
	SHARD_NAME=shard \
	SHARD_BIND_IP="0.0.0.0" \
	BACKUP_LOG_COUNT=0

# Add labels.
LABEL academy.dst.config.update="true"

# Install mods.
RUN set -x \
	&& if [ -n "$MODS" ] ; then \
		   IFS="," \
		&& for mod in $MODS; do echo "ServerModSetup(\"$mod\")" >> "$DST_HOME/mods/dedicated_server_mods_setup.lua"; done \
		&& cd "$DST_HOME/bin" \
		&& gosu $DST_USER ./dontstarve_dedicated_server_nullrenderer -only_update_server_mods \
		&& rm -r "$DST_HOME/.klei" \
	; fi

# Copy common scripts.
COPY /script/* /usr/local/bin/

# Copy static files.
COPY /static $DSTA_HOME

# Create pipe for the game console.
RUN set -x \
	&& mkfifo $DSTA_HOME/console \
	&& chown -R $DST_USER:$DST_USER $DSTA_HOME \
	&& mkdir -p $(dirname $CLUSTER_PATH) \
	&& chown $DST_USER:$DST_USER $(dirname $CLUSTER_PATH)

# Copy entrypoint script.
COPY /docker-entrypoint.sh /

# Set up healthcheck.
HEALTHCHECK --start-period=15m --interval=5m --timeout=1m --retries=3 CMD dst-server version --check

# Set up a volume for configuration files.
VOLUME ["$CLUSTER_PATH"]

# Set entrypoint and default command.
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dst-server", "start"]
