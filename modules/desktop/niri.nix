{ ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      kitty

      wl-clipboard
      cliphist
      noctalia-shell
      xwayland-satellite
      nautilus

      fuzzel
    ];
  };
}
