# shellcheck shell=bash

function extract {
	if [ $# -eq 0 ]; then
		echo -e '\033[32mUsage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>\033[0m'
		echo -e '\033[32m       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]\033[0m'
	fi

	for n in "$@"; do
		if [ ! -f "$n" ]; then
			echo -e "\033[31m'$n' - file doesn't exist\033[0m"
			return 1
		fi

		case "$n" in
			*.tar.bz2|*.tbz2|*.tar.xz|*.txz|*.tar|*.cbt) tar -xf "$n" ;;
			*.tar.gz|*.tgz) tar -zxf "$n" ;;
			*.tar.zst) tar -I zstd -xf ./"$n" ;;

			*.bz2) bunzip2 ./"$n" ;;
			*.xz)  unxz    ./"$n" ;;
			*.gz)  gunzip  ./"$n" ;;
			*.zst) zstd -d ./"$n" ;;

			*.cbr|*.rar) unrar x -ad ./"$n" ;;
			*.cbz|*.epub|*.zip) unzip ./"$n" ;;
			*.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd) 7z x ./"$n" ;;

			*.arc)  arc e  ./"$n" ;;
			*.lzma) unlzma ./"$n" ;;
			*.zpaq) zpaq x ./"$n" ;;
			*.cpio) cpio -id < ./"$n" ;;
			*.exe)  cabextract ./"$n" ;;
			*.z)    uncompress ./"$n" ;;

			*.cba|*.ace) unace x ./"$n" ;;
			*.cso) ciso 0 ./"$n" ./"$n.iso" && 7z x ./"$n.iso" && \rm -f "$n" ;;
			*.zlib) zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n" ;;
			*.dmg) hdiutil mount ./"$n" -mountpoint "./$n.mounted" ;;

			*) echo -e "extract: \033[31m'$n' - unsupported archive method\033[0m" && return 1 ;;
		esac
	done
}
