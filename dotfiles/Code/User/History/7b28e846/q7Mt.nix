{ config
, lib
, pkgs
, ...
}:

let



in

{

  home.packages = with pkgs; [

    scripts.helloWorld
    scripts.mtsd
    scripts.epr
    scripts.upd
  ];


}
