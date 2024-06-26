{
  description = "Example kickstart NixOS desktop environment.";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = inputs @ {
    self,
    home-manager,
    nixpkgs,
    ...
  }: let
    nixos-system = import ./system/nixos.nix {
      inherit inputs;
      username = "fatt";
      password = "fatt"; # super secure, i know
      desktop = "plasma5"; # optional: "gnome" by default, or "plasma5" for KDE Plasma
    };
  in {
    nixosConfigurations = {
      aarch64 = nixos-system "aarch64-linux";
      x86_64 = nixos-system "x86_64-linux";
    };
  };
}
