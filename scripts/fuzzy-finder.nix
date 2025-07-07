{ pkgs, lib }:

let 
	dir_list = [ "~/dev" "~/doc" "~/nixos" ];
in
pkgs.writeShellScriptBin "f" ''
	if [[ $# -eq 1 ]]; then
		selected=$1
	else
		selected=$(find ${lib.strings.concatStringsSep " " dir_list} -mindepth 1 -maxdepth 1 -type d | fzf)
	fi

	if [[ -z $selected ]]; then
		exit 0
	fi

	selected_name=$(basename "$selected" | tr . _)
	tmux_running=$(pgrep ${pkgs.tmux}/bin/tmux)

	if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
		${pkgs.tmux}/bin/tmux new-session -s $selected_name -c $selected
		exit 0
	fi

	if ! ${pkgs.tmux}/bin/tmux has-session -t=$selected_name 2> /dev/null; then
		${pkgs.tmux}/bin/tmux new-session -ds $selected_name -c $selected
	fi

	if [[ -z $TMUX ]]; then
		${pkgs.tmux}/bin/tmux attach -t $selected_name
	else
		${pkgs.tmux}/bin/tmux switch-client -t $selected_name
	fi
''
