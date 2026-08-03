{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.llmInference;
  inherit (lib)
    mkIf
    mkOption
    mkMerge
    mkEnableOption
    ;
in
{
  options.my = {
    llmInference.cuda = mkEnableOption "Enable CUDA support for LLM inference";
    llmInference.sycl = mkEnableOption "Enable SYCL support for LLM inference";
  };
  config = mkMerge [
    (mkIf cfg.cuda {
      environment.systemPackages = [
        (pkgs.llama-cpp.override { cudaSupport = true; })
      ];
      # nixpkgs.config.cudaSupport = true; # makes pkgs.llama-cpp build with CUDA
      nixpkgs.config.allowUnfree = true; 

      hardware.graphics.enable = true; # OpenGL/CUDA userspace bits
      hardware.nvidia = {
        modesetting.enable = true;
        open = false; # closed-source driver; flip to true if using open kernel modules on newer GPUs
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      services.xserver.videoDrivers = [ "nvidia" ];
    })
    (mkIf cfg.sycl {
      hardware.graphics.enable = true;
      environment.systemPackages = with pkgs; [
        llama-cpp-vulkan
        intel-compute-runtime
        intel-media-driver
        intel-graphics-compiler
      ];
    })
  ];
}
