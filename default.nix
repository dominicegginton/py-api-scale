{pkgs}:
with pkgs.python3Packages;
with pkgs.dockerTools; let
  py-api-scale = buildPythonApplication rec {
    pname = "py-api-scale";
    version = "0.1.0";
    propagatedBuildInputs = [fastapi uvicorn];
    src = ./.;
  };
in {
  default = py-api-scale;
  container = buildImage rec {
    name = "py-api-scale";
    tag = "latest";
    config.cmd = ["${py-api-scale}/bin/main.py"];
  };
}
