{ config, lib, pkgs, ... }:

{
  imports =
    [
	./hardware-configuration.nix
	../../modules/nixos/rust.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "daltrax";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  services.displayManager.ly.enable = true;
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--ssh" ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
    IdleAction = "ignore";
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  networking.networkmanager.wifi.powersave = false;
  systemd.services.NetworkManager-wait-online.enable = true;

  # Compile-time memory valve. A single rustc can exceed 4 GiB while this
  # machine has 7.7 GiB and previously zero swap — when RAM ran out the kernel
  # evicted running programs' executable pages instead of swapping, which froze
  # the desktop. Fix: zram (compressed, in-RAM, fast) as primary swap, plus an
  # 8 GiB disk swapfile as a hard backstop for spikes beyond RAM. High
  # swappiness tells the kernel to push anonymous pages (rustc's heap) to zram
  # rather than evicting file-backed code pages — that's what stops the freeze.
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024; # MiB -> 8 GiB
  }];
  boot.kernel.sysctl."vm.swappiness" = 100;

  # Bluetooth: enable the stack and power the adapter on at boot.
  # Manage devices interactively via `bluetuith` (TUI, like nmtui for BT).
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  users.users.ashutosh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # Audio stack: PipeWire as the server, ALSA for kernel drivers (incl. 32-bit
  # support for Steam/Wine), PulseAudio shim so legacy apps that talk pulse work.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    pulse.enable = true;
  };

  # Remap CapsLock -> Ctrl system-wide (covers ly login + virtual consoles).
  # Hyprland's own kb_options mirrors this for the graphical session.
  services.xserver.xkb.options = "ctrl:nocaps";
  console.useXkbConfig = true;

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    eza
    go
    nodejs
    ghostty
    wofi
    waybar
    hyprpaper
    kitty
    tailscale
    grim          # wayland screenshot capture
    slurp         # region selector (feeds grim/grimblast)
    wl-clipboard  # wl-copy/wl-paste (clipboard for screenshots)
    grimblast     # hyprland screenshot wrapper (copy/save/area/window)
    brightnessctl
    bluetuith
    claude-code
    pstree
  ];

  # Load brightnessctl's udev rules so members of the `video` group can write
  # to /sys/class/backlight/*/brightness without sudo.
  services.udev.packages = [ pkgs.brightnessctl ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Weekly nix store maintenance: GC anything older than 14 days (keeps a
  # couple of rollback points) and hardlink-dedupe identical files.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "claude-code" ];
  services.openssh.enable = false;
  system.stateVersion = "26.05";
}

