{ config, lib, pkgs, ... } :
{
  services.openssh = {
    enable = lib.mkDefault true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "rob" ];
    };
    extraConfig = ''
      PrintLastLog no
    '';
  };
}