{ config, pkgs, ... }:

{

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-chinese-addons
        fcitx5-gtk
        libsForQt5.fcitx5-qt
        fcitx5-material-color

        ((libsForQt5.fcitx5-qt.override { inherit (qt6) qtbase; }).overrideAttrs
          (old: rec { cmakeFlags = old.cmakeFlags ++ [ "-DENABLE_QT6=1" ]; }))
      ];
    };
  };


  environment.variables = {
    SDL_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
  };
}
