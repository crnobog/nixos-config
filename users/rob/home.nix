{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Robert Millar";
      user.email = "robert.millar@cantab.net";
    };
  };
  programs.jujutsu = {
    enable = true;
    settings = {
      user.name = "Robert Millar";
      user.email = "robert.millar@cantab.net";
    };
  };
  home.stateVersion = "26.05";
}
