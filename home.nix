{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cgasser";
  home.homeDirectory = "/home/cgasser";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ./turso)];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    nerdfonts

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    ### Language servers ###
    rust-analyzer
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.svelte-language-server
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    python311Packages.python-lsp-server
    taplo # TOML lsp
    marksman # Markdown lsp
    lua-language-server # Lua lsp
    gopls # Go language server
    clang-tools
    cmake-language-server
    terraform-ls
    nil
    zls # zig language server
    elixir-ls # elixir langauge server
    #######################

    ### Programing Languages ###
    cargo
    cargo-flamegraph
    clippy
    cargo-expand
    rustc
    rustfmt
    bun
    go
    elixir
    zig
    gcc
    ## Ocaml
    ocaml
    ocamlPackages.findlib
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    dune_3
    ############################

    obsidian
    logseq
    onefetch
    freshfetch
    arduino
    avrdude
    turso-cli
    flameshot
    logisim
    fd
    minikube
    k3s
    k3d
    helm
    docker
    jq
    gh
    openjdk
    graphviz
    gnuplot
    llvm
    lldb
    husky
    git-secrets
    lazygit
    glxinfo
    kitty
    spotify
    zellij
    ripgrep
    du-dust
    nushell
    zsh
    starship
    bat
    fzf
    eza
    python3
    gnupg
    pinentry-qt
    btop
    xclip
    nix-index
    act
  ];

  ##### Desktop Entries #####
  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      genericName = "obisidan";
      exec = "obsidian --disable-gpu";
      terminal = false;
      categories = ["Application"];
    };
    logseq = {
      name = "Logseq";
      genericName = "logseq";
      exec = "logseq --disable-gpu";
      terminal = false;
      categories = ["Application"];
    };
  };
  ###########################

  ##### Programs #####
  programs.helix = {
    enable = true;
    languages = { language = [
      {
        name = "rust";
        auto-format = true;
      }
    ];};
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        bufferline = "always";
      };
      keys.insert = {
        k = { j = "normal_mode"; };
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      ls = "eza";
      tree = "eza -T";
      gst = "git status";
      lg = "lazygit";
      img = "kitty +kitten icat";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_vi_key_bindings # Enable vi mode
      bind -M insert kj "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end" # 
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Front";
  };

  programs.eww = {
    enable = true;
    configDir = ./config/eww;
  };

  programs.git = {
    enable = true;
    userName = "Caleb Gasser";
    userEmail = "1561693+calebgasser@users.noreply.github.com";
  };

  programs.gpg = {
    enable = true;
  };
  ##### End Programs #####

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  ##### Configs/Dotfiles #####

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/zellij/config.kdl".source = config/zellij/config.kdl;
    ".config/kitty/kitty.conf".source = config/kitty/kitty.conf;
  };
  ##### End Configs/Dotfiles #####

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cgasser/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
