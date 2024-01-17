{ config
, lib
, pkgs
, ...
}:

let
  username = "ck";
  cursorName = "Bibata-Modern-Ice";
  cursorSize = 24;

  iconName = "Rose-Pine-Moon";
  themeName = "RosePine-Main-B";

  # iconName = "WhiteSur-dark";
  # themeName = "WhiteSur-dark";
in

{
  gtk.enable = true;

  home.packages = with pkgs; [

    bibata-cursors
    whitesur-cursors
    whitesur-icon-theme
    papirus-icon-theme

    # whitesur-kde
    whitesur-gtk-theme
    adw-gtk3

    gnome.gnome-themes-extra
    gnome.adwaita-icon-theme

  ];


  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "adwaita";
      package = [ pkgs.adwaita-qt ];
    };

  };

  gtk = {
    gtk4.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
    gtk3.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
    gtk3.bookmarks = [
      "file:///home/${username}/Desktop/"
      "file:///home/${username}/Downloads"
      "file:///home/${username}/Documents"
      "file:///home/${username}/Pictures"
      "file:///home/${username}/Music"
      "file:///run/media/${username}/"
      "mtp://HUAWEI_KKG-AN00_MDEBB20622200624/内部存储/骤雨/"
    ];

    theme = {
      # name = "Adwaita";
      # name = "Adwaita-dark";
      name = themeName;
    };

    iconTheme = {
      # name = "Adwaita";
      name = iconName;

    };

    cursorTheme = {
      name = cursorName;
      size = cursorSize;
    };

    # font = {
    #   # size = fontSize;
    #   name = "MesloLGM Nerd Font Mono";
    # };

  };

}
