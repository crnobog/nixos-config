{
  config,
  lib,
  pkgs,
  hostName,
  hosts,
  ...
}:
let 
  hostsByIp = lib.mapAttrs' (hostName: host: lib.nameValuePair host.ip [ host.hostName ]) hosts;
in
{
  imports = [
    ../users/rob
    ../modules/shell.nix
    ../modules/neovim.nix
    ../modules/openssh.nix
    ../modules/builder.nix
    ../modules/cpp.nix
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # settings = {
    #   substituters = [
    #     "https://cache.nixos-cuda.org"
    #   ];
    #   trusted-public-keys = [
    #     "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    #   ];
    # };
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
  ];
}
