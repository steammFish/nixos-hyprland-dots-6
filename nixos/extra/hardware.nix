{ config, pkgs, ... }:
{


  environment.systemPackages = with pkgs; [
    tlp
    powertop
    upower
    blueman
    pipewire
    wireplumber
    networkmanager

  ];


  # █▄▄ █░░ █░█ █▀▀ ▀█▀ █▀█ █▀█ ▀█▀ █░█
  # █▄█ █▄▄ █▄█ ██▄ ░█░ █▄█ █▄█ ░█░ █▀█

  #   boot.supportedFilesystems = [ "ntfs" ];
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


  # █▀ █▀█ █░█ █▄░█ █▀▄
  # ▄█ █▄█ █▄█ █░▀█ █▄▀

  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  # █▀█ █▀█ █░█░█ █▀▀ █▀█
  # █▀▀ █▄█ ▀▄▀▄▀ ██▄ █▀▄

  # powerManagement.enable = true;

  # services.power-profiles-daemon.enable = true;
  # # Whether to enable thermald, the temperature management daemon
  # services.thermald.enable = true;





}
