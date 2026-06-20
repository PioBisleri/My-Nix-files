{ config, pkgs, ... }: {

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "catppuccin-mocha-mauve-standard";
    };
  };

  xdg.dataFile."themes/catppuccin-mocha-mauve-standard" = {
    source = "${pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; }}/share/themes/catppuccin-mocha-mauve-standard";
    recursive = true;
  };

}