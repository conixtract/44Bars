{ config, ... }:

let
  polybarDir = "${config.home.homeDirectory}/44Bars/home/config/polybar";
in
{
  services.polybar = {
    enable = true;
    script = "./launch.sh";
    config = "${polybarDir}/config.ini";
  };

  # launch.sh is referenced relatively, so run the service from its dir
  systemd.user.services.polybar.Service.WorkingDirectory = polybarDir;
}
