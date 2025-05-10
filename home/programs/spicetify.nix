{ lib, config, inputs, username, pkgs, ...}: {

  imports = [
    # Example for NixOS
    spicetify-nix.homeManagerModules.spicetify 
  ];
  
  let
    # For Flakeless:
    # spicePkgs = spicetify-nix.packages;

  # With flakes:
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in
   
  programs.spicetify = {
  enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      shuffle # shuffle+ (special characters are sanitized out of extension names)
      beautifulLyrics
      oneko
      
      #cat jam
      src = pkgs.fetchFromGitHub {
        owner = "BlafKing";
        repo = "github:BlafKing/spicetify-cat-jam-synced";
        rev = "";
        hash = "";
      };
      # The actual file name of the extension usually ends with .js
      name = "cat-jam.js";
    ];
    theme = spicePkgs.themes.starryNight;

    enabledSnippets = [
      {
        "title": "Hide lyrics button",
        "description": "Hides the lyrics button in the playbar",
        "code": ".main-nowPlayingBar-lyricsButton { display: none; }",
        "preview": "resources/assets/snippets/hide-lyrics-button.png"
      },

    ];

  }

}
