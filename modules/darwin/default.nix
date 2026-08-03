{ ... } :
{
  imports = [
    ./users/rob.nix
  ];
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;    # Fixes Touch ID inside tmux/screen sessions
  };
}