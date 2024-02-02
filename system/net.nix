{ config, ... }: {
  networking.hostName = "satellite";

  networking.wireless.iwd.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  services.automatic-timezoned.enable = true;

  services.openssh.enable = true;
}
