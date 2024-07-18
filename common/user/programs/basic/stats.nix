{ pkgs, ... }:
with pkgs;
{
  home.packages = [ duf ];

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "nord";
        theme_background = false;
        shown_boxes = "proc cpu mem";
        proc_tree = true;
        proc_aggregate = true;
        mem_graphs = false;
        show_disks = true;
        update_ms = 1000;
      };
    };
  };

  services.batsignal = {
    enable = true;
  };
}
