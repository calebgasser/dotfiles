{config, lib, pkgs, ...}:
{

  ##### Programs #####
  virtualisation = {
    podman = {
      enable = true; 
      # dockerCompat = true; # can conflict with docker
      defaultNetwork.settings = {
        dns_enable = true;
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "postgres" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  Address        auth-method
      local all       all                    trust
      host  all       all     127.0.0.1/32   trust
      
    '';
    # initialScript = pkgs.writeText "backend-initScript" ''
    #   CREATE ROLE nixtest  WITH LOGIN PASSWORD 'nixtest' CREATEDB:
    #   CREATE DATABASE nixtest;
    #   GRANT ALL PRIVILEGES ON DATABASE nixtest TO nixtest;
    # '';
  };

  ##### End Programs #####
  users.users.cgasser = {
    isNormalUser = true;
    description = "Caleb Gasser";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  programs.fish.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  # Enable auto optimiztion for the store
  nix.settings.auto-optimise-store = true;

  # Docker install with rootless
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Garbage collection can be automated 
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.interactiveShellInit = ''
      	alias v='nvim'
      	alias vi='nvim'
    	alias vim='nvim'
    	alias ls='eza'
    	alias tree='eza -T'
    	alias gst='git status'
	alias lg='lazygit'
  '';
}
