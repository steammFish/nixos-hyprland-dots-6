{ config, pkgs, ... }: {


  programs.bash.enableCompletion = true;
  # programs.bash.interactiveShellInit = "";

  # users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.zsh = {
    zsh-autoenv.enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;

    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh.plugins = [ "git" "z" "extract" "dirhistory" "colored-man-pages" ];
    shellAliases = {
      home = "cd ~/.config/home-manager";
      sys = "cd /etc/nixos";
      ez = "hx ~/.zshrc";
    };
    # loginShellInit = "";
    # interactiveShellInit = "";
  };


}
