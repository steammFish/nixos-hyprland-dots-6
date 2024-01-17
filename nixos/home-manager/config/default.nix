{ config
, pkgs
, globalVariable
, ...
}:

let
  local =
    let
      fontSize = "18";
      fontFamily = "JetBrainsMono Nerd Font";
      username = globalVariable.username;
    in
    {

      yazi = ./yazi_preset;

      swappy =
        ''
          [Default]
          save_dir=$HOME/Desktop
          save_filename_format=swappy-%Y%m%d-%H%M%S.png
          show_pannel=false
          line_size=5
          text_size=${fontSize}
          text_font=${fontFamily}
          paint_mode=brush
          early_exit=false
          fill_shape=false
        '';

      yt-dlp =
        ''
          --ignore-errors
          -o ~/Videos/%(title)s.%(ext)s
          # Prefer 1080p or lower resolutions
          -f bestvideo[ext=mp4][width<=2000][height<=1200]+bestaudio[ext=m4a]/bestvideo[ext=webm][width<=2000][height<=1200]+bestaudio[ext=webm]/bestvideo[width<=2000][height<=1200]+bestaudio/best[width<=2000][height<=1200]/best
        '';

      filebrowser =
        ''
          {
            "address": "0.0.0.0",
            "database": "/home/${username}/.filebrowser/filebrowser.db",
            "log": "/home/${username}/.filebrowser/filebrowser.log",
            "port": 8888,
            "root": "/home/${username}",
            "username": "admin"
          }
        '';

    };


  featch = {
    fcitx5DictURL = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20220416.dict";
  };


  scripts = {
    helloWorld = pkgs.writeShellScriptBin "helloWorld" ''
      echo -e "\e[1;33m[=>]\e[0m Hello World!"
    '';

    mtvm = pkgs.writeShellScriptBin "mtvm" ''
      sudo mount /dev/nvme0n1p6  /VM
      echo -e "\e[1;33m[=>]\e[0m mount /VM."
      notify-send "mount /VM."
    '';

    mtsd = pkgs.writeShellScriptBin "mtsd" ''
      echo -e "\e[1;33m[=>]\e[0m run as sudoer!"
      sudo fdisk -l | grep nvme
      sudo mount /dev/nvme0n1p3 /mnt/
      echo -e "\e[1;33m[=>]\e[0m mount windows drive D to /mnt."
      notify-send "mount windows drive D to /mnt."
    '';

    upd = pkgs.writeShellScriptBin "upd" ''
      echo -e "\e[1;33m[=>]\e[0m run as sudoer!"
      sudo nixos-rebuild switch --flake /home/ck/nixos/
    '';

    epr = pkgs.writeShellScriptBin "epr" ''
      export all_proxy=http://192.168.43.1:10809/
      echo -e "\e[1;33m[=>]\e[0m have been set proxy $(all_proxy)."
    '';

    list-gtk-themes = pkgs.writeShellScriptBin "list-gtk-themes" ''
      ls /nix/store/*/share/themes
    '';
    list-icon-themes = pkgs.writeShellScriptBin "list-icon-themes" ''
      ls /nix/store/*/share/icons
    '';

  };


in

{

  home.file = {
    ".config/yazi".source = local.yazi;
    ".filebrowser.json".text = local.filebrowser;
    # ".config/yt-dlp/config".text = local.yt-dlp;
    # ".config/swappy/config".text = local.swappy;

  };

  # ~/.local/share
  xdg.dataFile."fcitx5/pinyin/dictionaries/zhwiki-20220416.dict".source = pkgs.fetchurl {
    url = featch.fcitx5DictURL;
    sha256 = "vyvsychfpRMSQWgxQfCxD3QllmKBjDdcbIvJiEDfz+8=";
  };

  home.packages = with pkgs; [

    scripts.helloWorld
    scripts.mtsd
    scripts.mtvm
    scripts.epr
    scripts.upd
    scripts.list-gtk-themes
    scripts.list-icon-themes

  ];


}
