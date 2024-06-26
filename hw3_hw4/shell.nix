with import <nixpkgs> { };

let
  pythonPackages = python311Packages;
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [
    pkgs.stdenv.cc.cc.lib
    git-crypt
    pythonPackages.venvShellHook
    pythonPackages.pip
    pythonPackages.faker
  ];

  postVenvCreation = ''
    pip install --upgrade pip setuptools wheel

    pip install faker

    exec zsh
  '';


  #shellHook = ''
  #  exec zsh
  #'';
}
