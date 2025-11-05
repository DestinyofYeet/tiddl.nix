{ python3Packages, pkgs, fetchPypi, lib, ... }:
let
  version = "2.8.0";

  ffmpegAsyncio = python3Packages.buildPythonPackage {
    name = "ffmpeg-asyncio";
    version = "0.1.3";
    pyproject = true;

    src = fetchPypi {
      pname = "ffmpeg_asyncio";
      version = "0.1.3";
      hash = "sha256-WIE6hgnGTAO1NHClVegX/Tum9ZRFiQ2Ai7gapNQnQqA=";
    };
    nativeBuildInputs = with python3Packages; [ setuptools-scm ];
    propagatedBuildInputs = with python3Packages; [ pyee ];
  };

in python3Packages.buildPythonApplication rec {
  inherit version;
  pname = "tiddl";

  pyproject = true;
  build-system = with python3Packages; [ setuptools ];

  propagatedBuildInputs = with python3Packages; [
    pydantic
    requests
    requests-cache
    click
    mutagen
    m3u8
    rich
    ffmpegAsyncio
  ];

  src = pkgs.fetchFromGitHub {
    owner = "oskvr37";
    repo = "tiddl";
    tag = "v${version}";
    hash = "sha256-ZKIrIjTv6apDjRDYK9RhvqpPC1g9gDJMka32Aa4bD9o=";
  };

  meta = {
    homepage = "https://github.com/oskvr37/tiddl";
    description =
      "TIDDL is the Python CLI application that allows downloading Tidal tracks and videos!";
    license = lib.licenses.asl20;
    mainProgram = "tiddl";
  };
}
