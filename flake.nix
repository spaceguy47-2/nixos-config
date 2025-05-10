{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    #nix-flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    zen-browser = { 
      url = "github:0xc000022070/zen-browser-flake"; 
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input  
      inputs.nixpkgs.follows = "nixpkgs"; 
    }; 

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations = {
      SantiPC = let
        username = "santiago";
	specialArgs = {
          inherit username;
	  inherit inputs;
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
	  
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./hosts/desktop
          ./users/${username}/nixos.nix

	  nix-flatpak.nixosModules.nix-flatpak

	  # hyprpanel :P
          {nixpkgs.overlays = [inputs.hyprpanel.overlay];}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username}.imports = [
	      ./users/${username}/home.nix
            ];
	    home-manager.extraSpecialArgs = inputs // specialArgs;
          }
        ];
      };
    };
  };
}
