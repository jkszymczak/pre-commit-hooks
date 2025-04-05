
{
  description = "Basic Flake for pre-commit dev";
  nixConfig.bash-prompt = "[Pre-Commit] -> ";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "Pre-Commit";
        buildInputs = with pkgs;[
          pre-commit
          shellcheck
      ];
    };
  };
}
