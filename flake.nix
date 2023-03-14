{
  description = "A very basic flake";

  nixConfig.sandbox = "false";

  outputs = { self, nixpkgs }: let 
  pkgs = import nixpkgs{system = "x86_64-linux";};
  in {

    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "pnpm-fetch";
      src = ./pnpm-lock.yaml;

      dontUnpack = true;

      __noChroot = true;

      buildInputs = [pkgs.nodePackages.pnpm pkgs.git pkgs.openssh ];

      buildPhase = ''
        mkdir -p $out
        cp $src pnpm-lock.yaml
        pnpm fetch
      '';
    };

  };
}
