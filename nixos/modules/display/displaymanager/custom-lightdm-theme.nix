environment.systemPackages = with pkgs; [
  (stdenv.mkDerivation {
    name = "aether-theme";
    src = fetchFromGitHub {
      owner = "NoiSek";
      repo = "Aether";
      rev = "main";
      sha256 = "1w5w15py5rbrw1ad24din7kwcjz82mh625d7b4r7i8kzb9knl7d6";
    };

    installPhase = ''
      mkdir -p $out/share/themes
      cp -r * $out/share/themes/Aether
    '';
  })
];
