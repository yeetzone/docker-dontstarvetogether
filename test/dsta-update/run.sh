#!/usr/bin/env bash

clean() {
	rm -f $file1 $file2
}
trap clean EXIT

file1=`mktemp`
file2=`mktemp`

docker run --rm $1 dst-server update > $file2 || exit 1
grep -Fq "Success! App '343050' fully installed." $file2 || exit 1
grep -Fq "DownloadMods" $file2 || exit 1

docker run --rm $1 dst-server update --all > $file2 || exit 1
grep -Fq "Success! App '343050' fully installed." $file2 || exit 1
grep -Fq "DownloadMods" $file2 || exit 1

docker run --rm $1 dst-server update --game > $file2 || exit 1
grep -Fq "Success! App '343050' fully installed." $file2 || exit 1
grep -Fq "DownloadMods" $file2 && exit 1

docker run --rm $1 dst-server update --mods > $file2 || exit 1
grep -Fq "Success! App '343050' fully installed." $file2 && exit 1
grep -Fq "DownloadMods" $file2 || exit 1

# Errors
cat > $file1 <<- EOF
usage: dst-server update [--all|--game|--mods]
EOF
docker run --rm $1 dst-server update --game --mods >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server update --all --game >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server update --all --mods >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server update --game --game >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server update foo >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server update --bar >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
docker run --rm $1 dst-server update --bar=foo >/dev/null 2> $file2 && exit 1
diff $file1 $file2 || exit 1
