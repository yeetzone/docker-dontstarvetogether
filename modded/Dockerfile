FROM dstacademy/dontstarvetogether
MAINTAINER DST Academy <support@dst.academy>

ARG MODS=""
ENV MODS=$MODS

RUN [[ -n "$MODS" ]] \
	&& echo "" >>$DST_HOME/mods/dedicated_server_mods_setup.lua \
	&& echo "" >>$DST_HOME/mods/dedicated_server_mods_setup.lua \
	&& for mod in $MODS; do echo "ServerModSetup(\"$mod\")" >>$DST_HOME/mods/dedicated_server_mods_setup.lua; done \
	&& dontstarve_dedicated_server_nullrenderer -only_update_server_mods
