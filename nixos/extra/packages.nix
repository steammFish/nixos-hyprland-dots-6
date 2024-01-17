{ config, pkgs, lib, ... }:
let

  ck-pkgs = with pkgs;  [

    # basic
    ntfs3g
    helix
    git
    wget
    unzip
    unrar
    wl-clipboard
    ripgrep
    bat
    fzf
    eza
    nmap
    dig # dns query tool. eg: `dig www.site.com` .

    # hyprland
    brightnessctl
    pamixer
    home-manager
    libnotify
    kitty
    wofi
    waybar
    dunst

    networkmanagerapplet # NetworkManager control applet for GNOME␍
    pavucontrol # PulseAudio Volume Control␍
    playerctl

    grim
    swappy
    slurp

    firefox
    floorp
    google-chrome
    spotify
    telegram-desktop
    vscode
    vlc
    imv
    zathura
    obsidian
    keepassxc
    gparted

    gotop
    htop
    filebrowser
    nix-prefetch-git
    xdg-user-dirs
    xdg-utils
    gsettings-desktop-schemas
    # libxdg_basedir
    # acpi

    # dev 
    # ffmpeg-full
    # dnsutils
    # gcc
    # gnumake
    # openssl

    # addtion
    rofi-wayland
    swww
    mako
    cava
    pywal
    cliphist
    qutebrowser
    swayidle
    wlogout
    swaylock-effects

    eww-wayland


    pipes
    # Animated pipes terminal screensaver
    cbonsai
    # Grow bonsai trees in your terminal
    spicetify-cli
    # Command-line tool to customize Spotify client.
    # https://spicetify.app/docs/getting-started
    audacious
    audacious-plugins
    # A lightweight and versatile audio player
    discord
    # All-in-one cross-platform voice and text chat for gamers

    aichat # Chat with gpt-3.5/chatgpt in terminal.
    file # show file information.
    toipe # typing test in the terminal



    material-icons
    material-symbols
    material-design-icons



  ];

  # https://github.com/prasanthrangan/hyprdots
  prasanthrangan-pkgs = with pkgs;  [

    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qtstyleplugin-kvantum
    bluez
    bluez-alsa
    bluez-tools
    catppuccin-kvantum
    ffmpegthumbs
    kde-cli-tools
    nwg-look
    grimblast
    hyprpicker
    polkit-kde-agent
    parallel
    imagemagick
    qt5ct
    neofetch
    dolphin
    ark


    # add this to bashrc `fortune | pokemonsay`.
    pokemonsay
    fortune
    pokemon-colorscripts-mac
    # dwt1-shell-color-scripts-unstable

    # https://gitlab.com/phoneybadger/pokemon-colorscripts


  ];



  # ML4W dotfiles
  # https://gitlab.com/stephan-raabe/dotfiles
  stephan-raabe-pkgs = with pkgs;  [

    alacritty
    chromium
    starship
    mpv
    freerdp

    pulseaudioFull
    figlet
    xautolock
    polkit
    polkit_gnome
    qalculate-gtk
    gum
    man-pages # extra man pages
    pfetch
    xfce.xfce4-power-manager
    xfce.mousepad
    xfce.tumbler
    # gnome.gvfs
    # xfce.thunar
    # xfce.exo

    python311Packages.pip
    python311Packages.psutil
    python311Packages.rich
    python311Packages.click

  ];

  # end_4
  end_4-pkgs = with pkgs;  [


    #   # by end_4
    #   gnome.gnome-bluetooth
    #   gnome.gnome-control-center
    #   gnome.gnome-keyring
    #   python311Packages.material-color-utilities
    #   python311Packages.build
    #   python311Packages.pillow
    #   python311Packages.poetry-core
    #   python311Packages.poetry-semver
    #   python311Packages.poetry-dynamic-versioning
    #   nodePackages.npm

    #   swaynotificationcenter
    #   hyprpaper
    #   blueberry
    #   curl
    #   fish
    #   foot
    #   fuzzel
    #   gjs
    #   gobject-introspection
    #   gtk-layer-shell
    #   libdbusmenu-gtk3
    #   meson
    #   plasma-browser-integration
    #   sassc
    #   typescript
    #   webp-pixbuf-loader
    #   tesseract
    #   yad
    #   ydotool
    #   gojq
    #   gradience
    #   lexend
    #   wlsunset

  ];

  fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji

    fira-go
    # Font with the same glyph set as Fira Sans 4.3 and additionally supports Arabic, Devenagari, Georgian, Hebrew and Thai.
    fira

    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    dejavu_fonts
    ubuntu_font_family

    font-awesome
    line-awesome
    material-symbols
    monaspace
    # jetbrains-mono

    (nerdfonts.override {
      fonts = [
        "SpaceMono"
        "JetBrainsMono"

        "FiraCode"
        "FiraMono"

        "RobotoMono"
        "FantasqueSansMono"
        "DroidSansMono"
        "Meslo"
        "Hack"
        "Iosevka"
      ];
    })
  ];

in
{

  environment.variables = {
    EDITOR = "hx";
  };

  # environment.systemPackages = with pkgs; [
  environment.systemPackages = lib.mkMerge [
    ck-pkgs
    prasanthrangan-pkgs
    stephan-raabe-pkgs
    end_4-pkgs
  ];

  fonts.packages = fonts;


}
