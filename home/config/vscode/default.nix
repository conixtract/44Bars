{ pkgs, lib, config, ... }: {
  # home.file.".config/Code/User/profiles/-10a5dd83/settings.json".source =  "/home/forestgump/44Bars/home/config/vscode/settings.json";
  # home.activation.vscode-settings = lib.mkAfter ''
  #   mkdir -p ${config.home.homeDirectory}/.config/Code/User/profiles/-10a5dd83/
  #   rm -f ${config.home.homeDirectory}/.config/Code/User/profiles/-10a5dd83/settings.json
  #   ln -s ${toString ./settings.json} ${config.home.homeDirectory}/.config/Code/User/profiles/-10a5dd83/settings.json
  #   chmod u+w ${toString ./settings.json}
  # '';

  home.activation.vscode-settings = lib.mkAfter ''
    cp ${config.home.homeDirectory}/.config/Code/User/profiles/-10a5dd83/settings.json ${config.home.homeDirectory}/44Bars/home/config/vscode/
  '';
  programs.vscode = { enable = true; };

  home.activation.saveExtensions = lib.mkAfter ''
    mkdir -p ${config.home.homeDirectory}/dotfiles
    ${config.programs.vscode.package}/bin/code --list-extensions > ${config.home.homeDirectory}/44Bars/home/config/vscode/extensions.txt
  '';
}
