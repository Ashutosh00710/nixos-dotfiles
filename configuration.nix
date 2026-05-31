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

  users.users.ashutosh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

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
    rustup
    go
    nodejs
    ghostty
    wofi
    waybar
    hyprpaper
    kitty
    tailscale
    neovim
    claude-code
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "claude-code" ];
  services.openssh.enable = false;
  system.stateVersion = "26.05";
}

