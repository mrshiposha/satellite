{ pkgs, ... }: with pkgs; {
  home.packages = [
    duf
  ];

  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "nord";
        shown_boxes = "proc cpu mem";
        proc_tree = true;
        mem_graphs = false;
        show_disks = false;
      };
    };
  };

  services.batsignal = {
    enable = true;
  };
}
