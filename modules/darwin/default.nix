{...}: {
  imports = [
    ./users/rob.nix
    ./homebrew.nix
    ./system-defaults.nix
    ./launchd.nix
    ../common/ssh.nix
  ];
  programs.ssh.extraConfig = ''
    Host *
      IgnoreUnknown UseKeychain
      UseKeychain yes
  '';
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true; # Fixes Touch ID inside tmux/screen sessions
  };
}
