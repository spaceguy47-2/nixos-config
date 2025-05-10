{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    #kde stuff
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.ark

    #productivity
    neovim
    obsidian
    thunderbird

    #utilities
    gnome-disk-utility
    nerdfetch
    wget
    
    #web
    brave

    #archives
    zip
    xz
    unzip
    p7zip

    #hyprland stuff
    hyprpanel
    rofi
    kitty

    #other
    vesktop
  ];
}
