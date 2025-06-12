{ config, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs;
      [

      ]);
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
  };

}
