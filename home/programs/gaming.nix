{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    lutris
    openmw
    vkbasalt
  ];
}
