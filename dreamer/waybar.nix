{lib, config, pkgs, ... }:
let 
  font = "RobotoMono Nerd Font";
  fontsize = "12";
  primary_accent = "cba6f7";
  secondary_accent = "89b4fa";
  tertiary_accent = "f5f5f5";
  background = "11111B";
  opacity = ".85";
  cursor = "Numix-Cursor";
  primary_background_rgba = "rgba(0.0, 0.0, 0.0, 0.0)";
  primary_background_hex = "000000";
  secondary_background_rgba = "rgba(0.0, 0.0, 0.0, 1.0)";
  secondary_background_hex = "000000";
  tertiary_background_rgba = "rgba(0.0, 0.0, 0.0, 1.0)";
  tertiary_background_hex = "000000";

in
{
	programs.waybar = {
		enable = true;
		systemd.enable = true;
		settings.secondBar = {
			height = 20;
			modules-left = [
				"bluetooth" 
			];
			modules-right = [
				"network"
			];
			modules-center = [
				"pulseaudio"
				"clock"
				"battery"
			];
			position = "top";
			battery = {
				states = {
					warning = 30;
					critical = 15;
				};
				format = "{capacity} {icon}";
				format-charging = "{capacity} ";
				format-icons = [""  "" "" "" ""];
			};
			pulseaudio = {
				format = "{volume} {icon}";
				format-bluetooth = "{volume} {icon} ";
				format-muted = "";
				format-icons = {
					#"alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
					"alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
					headphones = "";
					handsfree = "";
					headset = "";
					default = ["" ""];
				};
				on-click = "pavucontrol";
			};
			
			network = {	
				format-wifi = "  {essid}";
				format-ethernet = "{cidr}";
				format-disconnected = "⚠";
				max-length = 10;
			};
			bluetooth = {
				format = " {status}";
				format-connected = " {device_alias}";
				on-click = "overskride";
				#on-click = "hyprctl dispatch exec float blueberry";
			};
		};
		settings.miniBar = {
			height = 30;
			modules-center = [
				"custom/playerctl#backward" "custom/playerctl#play" "custom/playerctl#forward"
				#"custom/playerlabel" 
			];
			modules-left = [ "hyprland/workspaces" ];
			modules-right = [ 
				"power-profiles_daemon"
				"keyboard-state"
				#"temperature"
				];
			position = "bottom";
			keyboard-state = {
				capslock = true;
				format = "{name} {icon}";
					format-icons = {
						locked = "";
						unlocked = "";
					};
			};
		
			"custom/playerctl#backward"= {
				format= "󰙣 "; 
				on-click= "playerctl previous";
				on-scroll-up = "playerctl volume .05+";
				on-scroll-down = "playerctl volume .05-";
			};
			"custom/playerctl#play"= {
				format= "{icon}";
				return-type= "json";
				exec= "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
				on-click= "playerctl play-pause";
				on-scroll-up = "playerctl volume .05+";
				on-scroll-down = "playerctl volume .05-";
				format-icons= {
					Playing = "<span>󰏥 </span>";
					Paused = "<span> </span>";
					Stopped = "<span> </span>";
				};
			};
			"custom/playerctl#forward"= {
				format= "󰙡 ";
				on-click= "playerctl next";
				on-scroll-up = "playerctl volume .05+";
				on-scroll-down = "playerctl volume .05-";
			};
			"custom/playerlabel"= {
				format= "<span>󰎈 {} 󰎈</span>";
				return-type= "json";
				max-length= 40;
				exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
				on-click= "";
			};		
		};
		 style = ''
            * {
                border: none;
                border-radius: 0px;
                font-family: ${font};
                font-size: 14px;
                min-height: 0;
            }

            window#waybar {
                background: ${primary_background_rgba};
            }

            #workspaces {
                background: #${tertiary_background_hex};
                margin: 5px 5px;
                padding: 8px 5px;
                border-radius: 16px;
                color: #${primary_accent}
            }
            #workspaces button {
                padding: 0px 5px;
                margin: 0px 3px;
                border-radius: 16px;
                color: transparent;
                background: ${primary_background_rgba};
                transition: all 0.3s ease-in-out;
            }

            #workspaces button.active {
                background-color: #${secondary_accent};
                color: #${background};
                border-radius: 16px;
                min-width: 50px;
                background-size: 400% 400%;
                transition: all 0.3s ease-in-out;
            }

            #workspaces button:hover {
                background-color: #${tertiary_accent};
                color: #${background};
                border-radius: 16px;
                min-width: 50px;
                background-size: 400% 400%;
            }

            #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.forward
			{
				background: #${tertiary_background_hex};
                font-weight: bold;
                margin: 5px 0px;

			}
            #tray, #pulseaudio, #network, #battery, #bluetooth,
			#temperature, #clock {
                background: #${tertiary_background_hex};
                font-weight: bold;
                margin: 5px;
            }
            #tray, #pulseaudio, #network, #battery, #bluetooth, #temperature, #clock {
                color: #${tertiary_accent};
                border-radius: 10px 10px 10px 10px;
                padding: 15px;
                margin-left: 7px;
            }
            #oldclock {
                color: #${tertiary_accent};
                background: #${tertiary_background_hex};
                border-radius: 0px 0px 0px 40px;
                padding: 10px 10px 15px 25px;
                margin-left: 7px;
                font-weight: bold;
                font-size: 16px;
            }
            #custom-launcher {
                color: #${secondary_accent};
                background: #${tertiary_background_hex};
                border-radius: 0px 0px 40px 0px;
                margin: 0px;
                padding: 0px 35px 0px 15px;
                font-size: 28px;
            }

            #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.forward {
                background: #${tertiary_background_hex};
                font-size: 22px;
            }
            #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.forward:hover{
                color: #${tertiary_accent};
            }
            #custom-playerctl.backward {
                color: #${primary_accent};
                border-radius: 24px 0px 0px 10px;
                padding-left: 16px;
                margin-left: 7px;
            }
            #custom-playerctl.play {
                color: #${secondary_accent};
                padding: 0 5px;
            }
            #custom-playerctl.forward {
                color: #${primary_accent};
                border-radius: 0px 10px 24px 0px;
                padding-right: 12px; 
                /* margin-right: 7px */
            }
            #custom-playerlabel {
                background: #${tertiary_background_hex};
                color: #${tertiary_accent};
                padding: 0 20px;
                border-radius: 24px 10px 24px 10px;
                margin: 5px 0;
                font-weight: bold;
            }
            #window{
                background: #${tertiary_background_hex};
                padding-left: 15px;
                padding-right: 15px;
                border-radius: 16px;
                font-weight: normal;
                font-style: normal;
            }
        '';
	};
}