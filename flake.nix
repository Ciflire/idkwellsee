# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      #       ↑ Swap it for your system if needed
      #       "aarch64-linux" / "x86_64-darwin" / "aarch64-darwin"

      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default =
        pkgs.mkShell.override { stdenv = pkgs.gccStdenv; } # for C dev
          {
            packages = with pkgs; [
              rocmPackages.llvm.clang-tools-extra
              libgcc
              cmake
              imgui
              SDL2
              libGLU
            ];
            shellHook = "";
          };
    };
}
