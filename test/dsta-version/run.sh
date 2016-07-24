#!/usr/bin/env bash

clean() {
	rm -f $aux $aux1
}
trap clean EXIT

aux=`mktemp`
aux1=`mktemp`

version=`docker run --rm $1 dst-server version || exit 1`
[[ $version =~ ^[0-9]+$ ]] || ( echo "\$version == $version" && exit 1 )

version=`docker run --rm $1 dst-server version --local || exit 1`
[[ $version =~ ^[0-9]+$ ]] || ( echo "\$version == $version" && exit 1 )

version=`docker run --rm $1 dst-server version --upstream || exit 1`
[[ $version =~ ^[0-9]+$ ]] || ( echo "\$version == $version" && exit 1 )

message=`docker run --rm $1 dst-server version --check`
if [ $? -eq 0 ]; then
	[[ "$message" == "Version is up to date." ]] || ( echo "\$? == $? && \$message == $message" && exit 1 )
else
	[ "$message" == "Version is outdated." ] || ( echo "\$? == $? && \$message == $message" && exit 1 )
fi

cat > $aux <<- EOF
usage: dst-server version [--local|--upstream|--check]

Print the currently running version of the DST server.

   --local
      Return the local version.
   --upstream
      Return the currently released upstream version.
   --check
      Check if the currently running version is up to date.
EOF
docker run --rm $1 dst-server version --help >$aux1 || exit 1
diff $aux $aux1 || exit 1
docker run --rm $1 dst-server version --foo >/dev/null 2>$aux1 && exit 1
diff $aux $aux1 || exit 1
