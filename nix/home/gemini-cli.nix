{ pkgs }:

pkgs.buildNpmPackage {
  pname = "gemini-cli";
  version = "0.1.4"; # Or latest

  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.6.0.tgz";
    sha256 = "sha256-DhQ8wR5APBvFHLF/+Tc+AYvPOdTpcIDqOhxsBHRwC7U"; # let it fail once to get real hash
  };

  # npmDepsHash = "sha256-PLACEHOLDER_NPM_HASH"; # let it fail once to get real hash

  bin = [ "gemini" ];
}
