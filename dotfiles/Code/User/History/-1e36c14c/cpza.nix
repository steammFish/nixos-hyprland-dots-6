{ config
, pkgs
, ...
}:

let


  homeConfig = {

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


in

{

  imports = [ ./scripts.nix ./featch.nix ];

  home.file = {
    ".filebrowser.json".text = vars.homeConfig.filebrowser;
    ".config/yt-dlp/config".text = vars.homeConfig.yt-dlp;
    ".config/yazi".source = vars.homeAssets.yazi;
    # ".mybin".source = vars.homeAssets.mybin;

  };

}
