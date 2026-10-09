{ python3Packages }:

# Laya — open-weight, non-autoregressive decision model (Convai Innovations).
# Runs locally as the "should the bot reply?" judge for the OpenClaw slack-gate
# plugin. Packaged from the pure-Python PyPI wheel; torch/transformers come from
# nixpkgs, so no pip wheels with foreign shared libraries are involved (they
# would not load on NixOS without nix-ld).
#
# The model weights are not packaged: laya-serve reads them from the Hugging
# Face cache (~/.cache/huggingface), downloaded once on first use.
#
# To update: bump `version` and set `hash` from https://pypi.org/pypi/laya/<version>/json
# (the py3-none-any wheel's sha256), converted with:
#   nix hash convert --hash-algo sha256 --to sri <hex>
python3Packages.buildPythonApplication rec {
  pname = "laya";
  version = "0.4.1";
  format = "wheel";

  src = python3Packages.fetchPypi {
    inherit pname version format;
    dist = "py3";
    python = "py3";
    hash = "sha256-UlJzDYvmBK7NxsUq3rWR510rl+8/UieMups35APHhMc=";
  };

  dependencies = with python3Packages; [
    torch
    transformers
    safetensors
    huggingface-hub
    numpy
    # laya[serve]: the laya-serve HTTP server
    fastapi
    uvicorn
    python-multipart
  ];

  pythonImportsCheck = [ "laya" "laya.serve" ];
}
