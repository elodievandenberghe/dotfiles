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

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    fonts.packages = with pkgs; [
      fira-code
      fira-code-symbols
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted
    ];

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
        wget
        git
        stow
        unzip
        p7zip
        tree
        bat
        sl
        networkmanager
        clang
        libtool
        cmake
        gnumake
        brightnessctl
        xdg-utils
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        # ── Shell / System Info ──────────────────────────
        fastfetch
        btop
        acpi
        lshw
        dysk

        # ── Package / Nix Tools ──────────────────────────
        nixfmt
        nix-prefetch-git
        nix-direnv
        direnv
        nix-ld

        # ── Development Tools ────────────────────────────
        dbeaver-bin
        nodejs
        lxappearance

        # ── Audio / Video Tools ──────────────────────────
        mpv
        syncplay

        # ── GUI / Desktop Utilities ──────────────────────
        kitty
        wofi
        gsimplecal
        grim
        slurp

        # ── Productivity / Office ───────────────────────
        keepassxc
        teams-for-linux

        # ── Graphics / Media ────────────────────────────
        krita
        feh
        qbittorrent

        # ── Games & Launchers ────────────────────────────
        vintagestory
        pcsx2
        vesktop
        nautilus
        openmw
        portmod

        # ── Browsers ─────────────────────────────────────
        firefox
        chromium
      ]
      ++ (with pkgs-stable; [
        mcomix
        libreoffice
        prismlauncher
      ]);
  };
}
