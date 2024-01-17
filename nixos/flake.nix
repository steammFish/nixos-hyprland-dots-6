{
  description = "nix flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # fufexan-dotfiles = {
    #   url = github:fufexan/dotfiles;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , nixvim
    , nur
      # , fufexan-dotfiles
    }:
    let

      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };


      globalVariable = {
        username = "ck";
        hostname = "ck-nixos";
        userGroups = [ "video" "input" "networkmanager" "wheel" "keyd" ];
        timeZone = "Asia/Macau";
        locale = "en_US.UTF-8";
      };

    in
    {

      formatter.${system} = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      nixosConfigurations.${globalVariable.hostname} = lib.nixosSystem {
        inherit system; # <-- TODO: add lib;
        specialArgs = { inherit inputs self globalVariable; };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${globalVariable.username} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self globalVariable; };
          }

        ];
      };
    };
}
