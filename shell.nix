{pkgs}:
let
  load-test = pkgs.writeShellApplication rec {
    name = "load-test";
    text = ''
      ${pkgs.apacheHttpd}/bin/ab -n 1000 -c 10 -g load-test.txt http://localhost:8000/ 2>&1
    '';
  };
in
pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs: [
      python-pkgs.fastapi
      python-pkgs.uvicorn
    ]))
    load-test
  ];
}
