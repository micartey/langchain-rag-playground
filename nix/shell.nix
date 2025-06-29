{
  pkgs ? import <nixpkgs> { },
}:

let
  langchain-experimental = pkgs.callPackage ../pypi/langchain-experimental.nix {
    python = pkgs.python312;
    pkgs = pkgs;
  };
in
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    gcc
    just

    python312
    python312Packages.pip
    python312Packages.numpy
    python312Packages.langchain
    python312Packages.langchain-ollama
    python312Packages.langchain-chroma
    python312Packages.langchain-community
    python312Packages.tqdm
    python312Packages.unstructured

    langchain-experimental
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath buildInputs}
  '';
}
