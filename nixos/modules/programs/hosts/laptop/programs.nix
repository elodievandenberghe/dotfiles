{
  config,
  lib,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:

{
  options = {
    laptopPrograms.enable = lib.mkEnableOption "Enables laptop-specific programs and configuration";
  };

  config = lib.mkIf config.laptopPrograms.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };

    programs.nix-ld.enable = true;
    services.udisks2.enable = true;

    users.users.elodie.extraGroups = [
      "kvm"
    ];

    programs.nix-ld.libraries = with pkgs; [
      xorg.libICE
    ];


hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

    programs.nh = {
      enable = true;
    };


    programs.vim = {
      enable = true;
      defaultEditor = true;
    };

    services.emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
    nixpkgs.config.allowUnfree = true;
    services.udev.packages = [ pkgs.dolphin-emu ];

    environment.systemPackages =
      with pkgs;
      [
        # ── Core Utilities ────────────────────────────────
        vim
        dolphin-emu
        fuse
        wget
        git
        stow
        unzip
        p7zip
        tree
        bat
        distrobox
        sl
        # ── Shell / System Info ──────────────────────────
        fastfetch
        btop
        acpi
        lshw
        dysk

        # ── Package / Nix Tools ──────────────────────────
        nixfmt-rfc-style
        nix-prefetch-git
        nix-direnv
        direnv
        nix-ld

        # ── Development Tools ────────────────────────────
        dbeaver-bin
	jetbrains.rider 
        dotnetCorePackages.dotnet_8.sdk
    	dotnetCorePackages.dotnet_8.aspnetcore 
 	nodejs
        lxappearance
        csharpier
        omnisharp-roslyn
		

        # ── Audio / Video Tools ──────────────────────────
        mpv
        syncplay

        # ── GUI / Desktop Utilities ──────────────────────
        kitty
        nitrogen
        rofi
        flameshot
        gsimplecal
        kdePackages.breeze-icons
        yaru-theme

        # ── Productivity / Office ───────────────────────
        libreoffice
        keepassxc
        teams-for-linux

        # ── Graphics / Media ────────────────────────────
        krita
        feh
        qbittorrent

        # ── Games & Launchers ────────────────────────────
        lutris
	vintagestory
        pcsx2
        vesktop
        wineWowPackages.stable
        winetricks
        protontricks
        appimage-run
        xfce.thunar
        openmw
        portmod

        # ── Browsers ─────────────────────────────────────
        librewolf
        chromium
      ]
      ++ (with pkgs-stable; [
        mcomix
        prismlauncher
      ]);
  };
}
