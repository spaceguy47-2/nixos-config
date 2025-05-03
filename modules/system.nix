{ lib, config, pkgs, username, inputs, ...}: {
  #user stuff
    users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.trusted-users = [username];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  
  #garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;

  #enable flatpaks
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    nano
    neofetch
    nnn
    lxqt.lxqt-policykit
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    hyprlandPlugins.hyprscroller
    kdePackages.kio-admin
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # enable steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  programs.steam.gamescopeSession.enable = true;

  #enable sound
  #sound.enable = true; #depricated
  hardware.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true;
  };

  #enable hyprland
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;    
  };

  #enable sddm
  services.xserver.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  networking.networkmanager.enable = true;
  
  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
