{ pkgs, config, lib, self, inputs, ... }: {

  services.gnome-keyring.enable = true; # password manager

  nixpkgs = {
    overlays = [
      self.overlays.default
      inputs.nur.overlay
    ];
  };


}
