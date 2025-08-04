{ pkgs, lib, repo }:


pkgs.writeShellScriptBin "dvd" ''
	config_dir=$HOME/.config/white_snake
	if ! test -d $config_dir; then
		mkdir -p $config_dir
		touch $config_dir/config
	fi


	case $1 in
		insert | i)
		echo -n "new"
		;;

		menu | m)
		echo -n "search"
		;;

		*)
		echo -n "
dvd:
	play
	burn
	eject
	insert
	label
	pause
	stop
	rewind
	menu
	title
	track
	record
	chapter
	help
		"
		exit 0 
		;;
	esac

	repo=${repo}
	selected=$(curl -s "https://api.github.com/repos/$repo/contents/" \
			| jq -r '.[] | select(.type == "dir" and (.name | startswith(".") | not)) | .name' \
			| fzf)

	if [[ -z $selected ]]; then
		exit 0
	fi
	#todo check if exists
	touch .envrc

	echo "use flake 'github:$repo?dir=$selected'" >> .envrc

	direnv allow

	currentdir=$(pwd)
	echo $currentdir >> $config_dir/config

''
#
# pkgs.writeShellScriptBin "DISC" ''
# 	selected=$(nix eval github:2sleepy4u/machines#nixosConfigurations --apply builtins.attrNames --json | jq -r '.[]'  | fzf)
#
# 	if [[ -z $selected ]]; then
# 		exit 0
# 	fi
# 	echo $selected
# ''
