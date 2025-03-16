{ config, ... }:

{
  services.polybar = {
    enable = true;
    script = "./launch.sh";
    config = "${config.home.homeDirectory}/44Bars/home/config/polybar/config.ini";
  };

}
