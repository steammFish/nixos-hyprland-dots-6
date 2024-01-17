{ pkgs, config, ... }:

let
  yaziInit = ''
    ya() {
      if [ $# -eq 1 ]; then
        if [ -d "$1" ]; then
          cd -- "$1" || return 1
        else
          echo "路径不存在或不是一个目录"
          return 1
        fi
      fi

      tmp="$(mktemp -t "yazi-cwd.XXXXX")"
      yazi --cwd-file="$tmp"
      if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
      fi
      rm -f -- "$tmp"

    }
  '';

in

{
  services.tumbler.enable = true; ## A D-Bus thumbnailer service

  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  programs.thunar.enable = true;
  programs.thunar = {
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  environment.systemPackages = (with pkgs; [
    yazi
    fd
    ffmpegthumbnailer # a lightweight video thumbnailer 
    jq # json processor
    poppler_utils # A PDF rendering ...
    zoxide # A fast cd command that learns your habits
  ]);

  programs.zsh.shellInit = yaziInit;
  programs.bash.interactiveShellInit = yaziInit;


}
