{
  description = "My Quickshell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs"; # THIS IS IMPORTANT
    };
  };

  outputs = {
    self,
    nixpkgs,
    quickshell,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: let
      my-quickshell = pkgs.writeShellScriptBin "my-quickshell" ''
        qs -p .
      '';
    in {
      default =
        pkgs.mkShell
        {
          packages = with pkgs; [
            kdePackages.qtdeclarative
            quickshell.packages.${pkgs.system}.default
            my-quickshell
          ];
          shellHook = ''
            echo "Generating empty .qmlls.ini file if non-existent"
            touch .qmlls.ini
          '';
        };
    });
  };
}
