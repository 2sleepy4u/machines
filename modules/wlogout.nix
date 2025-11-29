{lib, config, pkgs, ... }:
{
	programs.wlogout = {
		enable = true;
		layout = [{
			label = "logout";
			action = "sleep 1; hyprctl dispatch exit";
			text = "Logout";
			keybind = "e";
		}
		{
			label = "reboot";
			action = "sleep 1; reboot";
			text = "Reboot";
			keybind = "r";
		}
		{
			label = "shutdown";
			action = "sleep 1; poweroff";
			text = "Shutdown";
			keybind = "s";
		}
		{
			label = "lock";
			action = "swaylock \
					  --screenshots \
					  --clock \
					  --indicator \
					  --indicator-radius 100 \
					  --indicator-thickness 7 \
					  --effect-blur 7x5 \
					  --effect-vignette 0.5:0.5 \
					  --ring-color bb00cc \
					  --key-hl-color 880033 \
					  --line-color 00000000 \
					  --inside-color 00000088 \
					  --separator-color 00000000 \
					  --grace 0 \
					  --fade-in 0.2";
			text = "Lock";
			keybind = "l";
		}];
	};
}
