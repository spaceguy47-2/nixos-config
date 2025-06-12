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
    obsidian
    thunderbird

    #utilities
    gnome-disk-utility
    nerdfetch
    wget
    grim
    slurp
    wl-clipboard
    audacity
    
    #java
    jdk17

    #web
    brave

    #archives
    zip
    xz
    unzip
    p7zip
    unrar

    #hyprland stuff
    hyprpanel
    rofi
    kitty

    #other
    vesktop
    davinci-resolve
    ollama-rocm
    obs-studio
  ];
}
