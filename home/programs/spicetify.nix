{ lib, config, pkgs, inputs, username, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      beautifulLyrics
      oneko
    ];

    theme = spicePkgs.themes.starryNight;

    enabledSnippets = [
      ''

      ''
    ];
  };
}
