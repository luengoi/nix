{ ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      # Fonts
      font_family = "MesloLGS NF";
      font_size = 12;

      # Configuraton
      enable_audio_bell = false;
      url_style = "curly";
      cursor_shape = "beam";
      cursor_beam_thickness = 1.8;
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      window_padding_width = 0;
      background_opacity = 1;
      shell = "zsh --login";
    };

    extraConfig = ''
      ${builtins.readFile ./theme.conf}
    '';
  };
}
