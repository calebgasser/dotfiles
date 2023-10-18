{pkgs, ...}:
{
  virtualisation = {
    podman = {
      enable = true; 
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enable = true;
      };
    };
  };
}
