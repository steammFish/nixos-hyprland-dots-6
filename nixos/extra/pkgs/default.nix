{ config, pkgs, lib, ... }:
let

  themes =
    let

      # 定义一个导入主题的函数
      themeImporter = themeName: import (./${themeName}-theme.nix) {
        stdenv = pkgs.stdenv;
        fetchgit = pkgs.fetchgit;
        fetchFromGitHub = pkgs.fetchFromGitHub;
        makeWrapper = pkgs.makeWrapper;
        pkgs = pkgs;
        inherit lib; # lib = nixpkgs.lib;
      };


    in
    {
      everforest-theme = themeImporter "everforest";
      gruvbox-theme = themeImporter "gruvbox";
      rose-pine-theme = themeImporter "rose-pine";
    };

in
{
  environment.systemPackages = with pkgs; [
    # home.packages = with pkgs; [

    themes.everforest-theme
    themes.gruvbox-theme
    themes.rose-pine-theme
  ];



}
