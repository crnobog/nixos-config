{ config, lib, pkgs, hostname, ... }:
{
  imports = [
    ../home/rob   
    ../modules/shell.nix
    ../modules/neovim.nix
    ../modules/openssh.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  time.timeZone = "America/Vancouver"; 
  i18n.defaultLocale = "en_CA.UTF-8";
  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    btop
    curl
    fd
    fzf
    git
    ripgrep
    tmux
    unzip
    wget
    yazi
  ];
}