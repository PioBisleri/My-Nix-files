{ config, pkgs, ... }: {

  programs.fetch = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixos";
      flake-update = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      garbage = "sudo nix-collect-garbage -d";
      generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      ls = "ls --color=auto";
      ll = "ls -lah";
      ".." = "cd ..";
      "..." = "cd ../..";
      grep = "grep --color=auto";
      ":q" = "exit";
      la = "ls -la";
      l = "ls -l";
      tree = "ls --tree";
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      mkcd = "mkdir -p $1 && cd $1";
      df = "df -h";
      du = "du -h";
      free = "free -h";
      ps = "ps auxf";
      ports = "ss -tulanp";
      vim = "nvim";
      vi = "nvim";
      cat = "bat";
      y = "yazi";
      g = "git";
      gi = "git init";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
      gd = "git diff";
      gco = "git checkout";
      gb = "git branch";
      clean = "sudo nix-collect-garbage -d && sudo nix optimise-store";
      search = "nix search nixpkgs";

    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      save = 10000;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    initContent = ''
      fetch
      eval "$(starship init zsh)"
    '';
  };

  xdg.configFile."starship.toml" = {
    text = ''
      format = "$os $username :: $directory $git_branch$git_status $time\n$character"

      palette = "catppuccin_mocha"

      [palettes.catppuccin_mocha]
      rosewater = "#f5e0dc"
      flamingo = "#f2cdcd"
      pink = "#f5c2e7"
      mauve = "#cba6f7"
      maroon = "#eba0ac"
      red = "#f38ba8"
      peach = "#fab387"
      yellow = "#f9e2af"
      green = "#a6e3a1"
      teal = "#94e2d5"
      sky = "#89dceb"
      sapphire = "#74c7ec"
      blue = "#89b4fa"
      lavender = "#b4befe"
      text = "#cdd6f4"
      subtext1 = "#bac2de"
      subtext0 = "#a6adc8"
      overlay2 = "#9399b2"
      overlay1 = "#7f849c"
      overlay0 = "#6c7086"
      surface2 = "#585b70"
      surface1 = "#45475a"
      surface0 = "#313244"
      base = "#1e1e2e"
      mantle = "#181825"
      crust = "#11111b"

      [os]
      disabled = false
      style = "bold blue"

      [username]
      show_always = true
      style_user = "bold blue"
      style_root = "bold red"
      format = "[$user]($style)"

      [directory]
      style = "bold green"
      format = "[$path]($style)"
      truncation_length = 3
      truncation_symbol = "../"

      [git_branch]
      format = "[$symbol$branch]($style)"
      style = "bold mauve"

      [git_status]
      style = "mauve"
      format = "[$all_status$ahead_behind]($style)"

      [time]
      disabled = false
      format = "[$time]($style)"
      time_format = "%H:%M"
      style = "bold blue"

      [cmd_duration]
      format = "[$duration]($style)"
      style = "bold yellow"
      min_time = 5000

      [nix_shell]
      format = "[$symbol$state($name)]($style)"
      style = "bold lavender"
      symbol = "❄"

      [character]
      success_symbol = "[▶](bold mauve)"
      error_symbol = "[▶](bold red)"
      vicmd_symbol = "[◀](bold green)"
      format = "$symbol"
    '';
  };

}
