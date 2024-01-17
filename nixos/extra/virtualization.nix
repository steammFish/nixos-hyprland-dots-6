{ config, pkgs, globalVariable, ... }:
let
  username = globalVariable.username;
in
{

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    docker-compose

    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    bridge-utils
    gnome.adwaita-icon-theme
    virtiofsd

  ];

  # virtualisation.vmware.host.enable = true;
  # virtualisation.vmware.guest.enable = true;


  # █▀▄ █▀█ █▀▀ █▄▀ █▀▀ █▀█
  # █▄▀ █▄█ █▄▄ █░█ ██▄ █▀▄

  users.extraGroups.docker.members = [ username ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };


  # █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █▄▄ █▀█ ▀▄▀
  # ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █▄█ █▄█ █░█

  users.extraGroups.vboxusers.members = [ username ];
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest.enable = true;
  };



  # █▀█ █▀▀ █▀▄▀█ █░█
  # ▀▀█ ██▄ █░▀░█ █▄█

  users.users.${username}.extraGroups = [ "libvirtd" ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

}

# 查看网络
# $ sudo virsh net-list --all

# qemu 启动网络
# $ sudo virsh net-start default

# qemu 网络自启
# $ sudo virsh net-autostart default

