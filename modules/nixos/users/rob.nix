{ ... } : 
{
  users.users.rob = {
    isNormalUser = true;
    description = "Robert Millar";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];
  };
}