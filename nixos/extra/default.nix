{ config, pkgs, lib, inputs, self, ... }:
{

  imports = [
    # ./template.nix
    ./packages.nix
    ./hardware.nix
    ./input-method.nix
    ./fonts.nix
    ./zsh.nix
    ./file-manager.nix
    ./editor.nix
    ./virtualization.nix
    ./networking.nix
    ./pkgs

  ];


  # █▀▄▀█ █ █▀ █▀▀
  # █░▀░█ █ ▄█ █▄▄

  # Enable dconf (System Management Tool)
  # programs.dconf.enable = true;
  # services.xserver.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(meta, esc)";
            esc = "overload(esc, capslock)";
          };
        };
      };
    };
  };


  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };


  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl suspend";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/systemctl";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/mount";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/umount";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/fdisk";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-channel";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };



  # █▄▄ ▄▀█ █▀ █ █▀▀
  # █▄█ █▀█ ▄█ █ █▄▄

  environment.systemPackages = with pkgs; [ helix git ];

  services.v2raya.enable = true;
  programs.hyprland.enable = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {

      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
        "ngrok"
      ];
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };


}
