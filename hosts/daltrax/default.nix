{ config, lib, pkgs, ... }:

{
  imports =
    [       
	./hardware-configuration.nix
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
    gcc            # provides cc/ld — needed by cargo to link Rust crates
    pkg-config     # most native-binding crates use it to find system libs
    cargo
    rustc
    rust-analyzer
    go
    nodejs
    ghostty
    wofi
    waybar
    hyprpaper
    kitty
    tailscale
    neovim
    brightnessctl
    bluetuith
    claude-code
    pstree
  ];

  # Load brightnessctl's udev rules so members of the `video` group can write
  # to /sys/class/backlight/*/brightness without sudo.
  services.udev.packages = [ pkgs.brightnessctl ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "claude-code" ];
  services.openssh.enable = false;
  system.stateVersion = "26.05";
}

