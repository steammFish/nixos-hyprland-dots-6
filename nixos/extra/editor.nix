{ pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  programs.nixvim.enable = true;
  programs.nixvim = {

    colorschemes.gruvbox.enable = true;
    plugins.lightline.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
    ];

    options = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2; # Tab width should be 2
    };

    keymaps = [
      {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "<leader>m";
        options.silent = true;
        action = "<cmd>!make<CR>";
      }
    ];

    globals.mapleader = ","; # Sets the leader key to comma

    extraConfigLua = ''
      -- Print a little welcome message when nvim is opened!
      print("Hello world!")
    '';

  };


  # programs.neovim.enable = true;
  # programs.neovim = {
  #   viAlias = true;
  #   vimAlias = true;
  # };


}
