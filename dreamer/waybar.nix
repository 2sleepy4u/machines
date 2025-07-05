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
  tertiary_background_rgba = "rgba(0.0, 0.0, 0.0, 0.5)";
  tertiary_background_hex = "000000";

in
{
	programs.waybar = {
		enable = true;
		systemd.enable = true;
		settings.secondBar = {
			width = 15;
			modules-left = [];
			modules-right = [];
			modules-center = [
				#"bluetooth" 
				"network"
				"pulseaudio"
				"clock"
				"battery"
			];
			position = "left";
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
				format-muted = "M ";
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
				format-wifi = " ";
				format-ethernet = "";
				format-disconnected = "⚠";
				tooltip-format = "{essid}";
				max-length = 10;
			};
			bluetooth = {
				format = " {status}";
				format-connected = " {device_alias}";
				format-off = "󰂲";
				on-click = "overskride";
				#on-click = "hyprctl dispatch exec float blueberry";
			};
		};
		
		 style = ''
			#pulseaudio-slider slider {
				border-radius: 5px;
			}

			#pulseaudio-slider trough {
				min-height: 80px;
				min-width: 10px;
				border-radius: 5px;
				background-color: black;
			}
			#pulseaudio-slider highlight {
				min-width: 10px;
				border-radius: 5px;
				background-color: purple;
			}
            * {
                border: none;
                border-radius: 0px;
                font-family: ${font};
                font-size: 12px;
                min-height: 0;
            }

            window#waybar {
                background: ${primary_background_rgba};
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

            #window{
                background: #${tertiary_background_hex};
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 16px;
                font-weight: normal;
                font-style: normal;
            }
        '';
	};
}
