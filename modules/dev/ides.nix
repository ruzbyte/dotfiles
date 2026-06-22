{ ... }: {
  flake.nixosModules.ides = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      jetbrains.rider
      jetbrains.idea
      android-studio

      zed-editor
      vscode

      # good old chrome the ide
      google-chrome
    ];
  };
}
