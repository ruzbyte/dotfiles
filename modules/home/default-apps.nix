{ ... }: {
  flake.homeModules.defaultApps = { ... }: {
    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "application/pdf" = "zen.desktop";
        "inode/directory" = "yazi.desktop";
        "text/plain" = "dev.zed.Zed.desktop";
      };
    };
  };
}
