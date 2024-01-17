{ lib, stdenv, fetchgit, ... }:

stdenv.mkDerivation {
  name = "Everforest-GTK-Theme";
  src = fetchgit {
    url = "https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git";
    rev = "8481714cf9ed5148694f1916ceba8fe21e14937b";
    sha256 = "15gl3ckqld7mz7g9cw9ygp283npxrfa8pcbj63m6z79hxy97dv9l";
  };

  installPhase = ''
    cd $src
    if ! [ -d $src/icons -a -d $src/themes ]; then
      echo "Icons or themes directory not found!"
      exit 1
    fi

    mkdir -p $out/share/icons
    mkdir -p $out/share/themes

    cp -r $src/icons/* $out/share/icons/
    cp -r $src/themes/* $out/share/themes/
  '';

  meta = {
    preferLocalBuild = true;
    preferLocalBuildUseSubstitutes = true;
    description = "A GTK theme based on the colours of Sainnhe's great theme ...";
    homepage = "https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme";
    license = lib.licenses.gpl3;
    maintainers = [ lib.maintainers.tadfisher ];
    platforms = lib.platforms.all;
  };
}
