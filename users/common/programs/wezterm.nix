{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        enable_wayland = false, -- https://github.com/wez/wezterm/issues/4483

        color_scheme = "nord",
        window_background_opacity = 0.7,
        use_fancy_tab_bar = false,

        colors = {
          tab_bar = {
            background = "#2e3440",

            active_tab = {
              bg_color = "#81a1c1",
              fg_color = "#e5e9f0",
            },

            inactive_tab = {
              bg_color = "#4c566a",
              fg_color = "#d8dee9",
            },

            inactive_tab_hover = {
              bg_color = "#5e81ac",
              fg_color = "#d8dee9",
              italic = true,
            },

            new_tab = {
              bg_color = "#3b4252",
              fg_color = "#d8dee9",
            },

            new_tab_hover = {
              bg_color = "#5e81ac",
              fg_color = "#d8dee9",

              italic = true,
            },
          },
        },
      }
    '';
  };
}
