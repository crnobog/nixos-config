{ pkgs, pkgs-unstable, lib, hosts, hostName, ... } :
{
  imports = [
    ./shell.nix
    ./openssh.nix
    ./builder.nix
    ./cpp.nix
    ./llm-inference.nix
    ./nfs.nix
    ./users/rob.nix
  ];

  nix.gc = {
    automatic = true;
    interval = "weekly";
    options = "--delete-older-than 30d";
  };

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    hosts = lib.mapAttrs' (hostName: host: lib.nameValuePair host.ip [ host.hostName ]) hosts;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs = {
    ssh.startAgent = true;
    nix-ld.enable = true;
  };

  environment.pathsToLink = [
    "/share/zsh"
  ];

  environment.systemPackages = with pkgs; [
    bat
    btop
    curl
    fd
    fzf
    git
    nixfmt
    ripgrep
    tmux
    unzip
    wget
    yazi
    
    pkgs-unstable.codex
  ];
}