{pkgs}:
{
	programs.gamemode.enable = true;
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
	programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];

}
