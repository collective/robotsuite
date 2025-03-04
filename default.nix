{
  pkgs ? import ./nix { nixpkgs = sources."nixpkgs-20.09"; },
  sources ? import ./nix/sources.nix { },
  python ? "python39",
}:

(import ./setup.nix { inherit pkgs sources python; }).package
