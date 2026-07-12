{
  config,
  lib,
  pkgs,
  ...
}:
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

  users.users.rob.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKujA9W5GVAxQxS+mcYEKDw1LMonXaXVwUvJ3CLkTUGo rob@laptop"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIT4qYJak0Yp58rH213qi3cVCCGzduCSb8ZNxCvyZgww rob@meshify"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAUsI71T8IWeWGIQY8G7ckNVZcN/scUHZ4yZwCsN7tGM rob@puck"
  ];
}
