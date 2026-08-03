{
  config,
  lib,
  pkgs,
  ...
}:
let 
  cfg = config.my.cpp;
  inherit (lib) mkIf mkOption;
in
{
  options.my = { 
    cpp.enable = mkOption {
      description = "Enable C++ / LLVM toolchain and related tooling";
      default = false;
      type = lib.types.bool;
    };
  };
  config = mkIf cfg.enable {
    # --- C++ / LLVM toolchain ---
    # llvmPackages_latest always tracks the newest LLVM release available in
    # the nixpkgs channel you're pinned to (currently resolves to LLVM 21 as
    # of mid-2026) — using the "_latest" alias instead of a hardcoded version
    # number means `nix flake update` picks up new majors automatically.
    environment.systemPackages = with pkgs; [
      llvmPackages_latest.clang
      llvmPackages_latest.lld
      llvmPackages_latest.lldb
      llvmPackages_latest.libcxx
      llvmPackages_latest.clang-tools # clangd, clang-format, clang-tidy
      llvmPackages_latest.bintools

      # build systems
      cmake
      gnumake
      mold # fast linker; pass -fuse-ld=mold, big win on link-heavy C++ builds
      ninja
      pkg-config

      # C++ perf / debugging tooling
      bpftrace
      perf # `perf` matched to the running kernel
      gdb
      heaptrack
      hotspot # GUI viewer for perf.data / heaptrack files
      hyperfine # quick CLI benchmarking
      linuxPackages.bcc # extra BPF tracing tools, optional but handy
      lldb
      ltrace
      strace
      valgrind

      # rust
      rustup
      rustfmt
      rust-analyzer

      # source control
      git
      jj-fzf
      jj-starship
      jujutsu

      # misc tools
      delta
      jq
    ];

    # Let non-root users run `perf record`/`perf stat` without sudo.
    boot.kernel.sysctl."kernel.perf_event_paranoid" = 1;
  };
}
