#!/bin/bash

tmp_script=$(mktemp)
cp 'extract.sh' "$tmp_script"

if sed --version 2>/dev/null | grep -q 'GNU'; then
	sed_inplace=(-i)
else
	sed_inplace=(-i '')
fi

# parameters: tool, patern
function optional {
	if ! command -v "$1" &> /dev/null; then
		echo "warning: $1 not found" 1>&2
		sed "${sed_inplace[@]}" "$2" "$tmp_script"
	fi
}

optional bunzip2 '/\*\.bz2)/d'
optional unxz '/\*\.xz)/d'
optional gunzip '/\*\.gz)/d'
optional zstd '/\*\.tar\.zst)/d'
optional zstd '/\*\.zst)/d'

optional unrar '/\*\.cbr|\*\.rar)/d'
optional unzip '/\*\.cbz|\*\.epub|\*\.zip)/d'
optional 7z '/\*\.7z|\*\.apk|\*\.arj|\*\.cab|\*\.cb7|\*\.chm|\*\.deb|\*\.iso|\*\.lzh|\*\.msi|\*\.pkg|\*\.rpm|\*\.udf|\*\.wim|\*\.xar|\*\.vhd)/d'

optional arc '/\*\.arc)/d'
optional unlzma '/\*\.lzma)/d'
optional zpaq '/\*\.zpaq)/d'
optional cpio '/\*\.cpio)/d'
optional cabextract '/\*\.exe)/d'
optional uncompress '/\*\.z)/d'

optional unace '/\*\.cba|\*\.ace)/d'
optional ciso '/\*\.cso)/d'
optional zlib-flate '/\*\.zlib)/d'
optional hdiutil '/\*\.dmg)/d'

echo '# Github: https://github.com/Chen1Plus/Extract'
sed -e '/^#/d' -e '/^$/d' "$tmp_script"
rm "$tmp_script"
