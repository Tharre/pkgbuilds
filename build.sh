#!/bin/bash -e

cur_pkgver() {
	parse_srcinfo --json < .SRCINFO | jq -r '(if .epoch == null then "" else
			.epoch + ":" end + .pkgver + "-" + .pkgrel) as $version
			| .packages | to_entries[] | [.key, $version] | @tsv' | sort
}

for dir in $(aur graph */.SRCINFO | tsort | tac); do
	pushd "$dir" > /dev/null
	if [ $(vercmp $(join -o 1.2,2.2 -a2 -e '0' <(aur repo -Sld sr.ht) <(cur_pkgver) | head -n1)) -lt 0 ]; then
		echo "=== Building $dir ==="
		aur build -s -c -r /home/build/local -d localrepo -- -c -u -- --noprogressbar
	fi
	popd > /dev/null
done
