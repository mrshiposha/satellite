{ pkgs, ... }: with pkgs; {
  programs.zsh = {
    enable = true;
    plugins = [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
    ];

    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word


      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        source ${./p10k/full.zsh}
      else
        source ${./p10k/minimal.zsh}
      fi
    '';
  };
}
