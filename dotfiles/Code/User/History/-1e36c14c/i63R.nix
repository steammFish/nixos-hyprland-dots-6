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


  featch  = {
    dictURL = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20220416.dict";
  };


    scripts = {
    helloWorld = pkgs.writeShellScriptBin "helloWorld" ''
      echo Hello World
    '';

    mtsd = pkgs.writeShellScriptBin "mtsd" ''
      echo run as sudoer!
      sudo fdisk -l | grep nvme
      sudo mount /dev/nvme0n1p3 /mnt/
      echo "mount windows drive D to /mnt."
      notify-send "mount windows drive D to /mnt."
    '';

    upd = pkgs.writeShellScriptBin "upd" ''
      echo run as sudoer!
       sudo nixos-rebuild switch --flake /home/ck/nixos/
    '';

    epr = pkgs.writeShellScriptBin "epr" ''
      export all_proxy=http://192.168.43.1:10809/
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

    xdg.dataFile."fcitx5/pinyin/dictionaries/zhwiki-20220416.dict".source = pkgs.fetchurl {
    url = dictURL;
    sha256 = "vyvsychfpRMSQWgxQfCxD3QllmKBjDdcbIvJiEDfz+8=";
  };

    home.packages = with pkgs; [

    scripts.helloWorld
    scripts.mtsd
    scripts.epr
    scripts.upd
  ];


}
