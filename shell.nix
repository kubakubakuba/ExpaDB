with import <nixpkgs> {};
let
  pp = pkgs.python311Packages;
in pkgs.mkShell rec{
  buildInputs = [
    maven
    jdk
    vscode-fhs
 ];

  shellHook = ''
    exec zsh
  '';

}
