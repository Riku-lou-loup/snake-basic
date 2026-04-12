{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    bashInteractive
    coreutils
    gnumake
    vice
    xorg.xorgserver
    xorg.xset
  ];

  shellHook = ''
    echo "Snake 64 dev shell"
    echo "Available commands: make build | make run | make smoke"
    echo "VICE tools: x64sc, x64, petcat, c1541"
  '';
}
