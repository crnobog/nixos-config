{ inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = ".bak";
  home-manager.overwriteBackup = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}
