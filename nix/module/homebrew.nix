{
  homebrew = {
    enable = true;
    global.autoUpdate = false;

    taps = [
      "dlvhdr/formulae"
      "charmbracelet/tap"
      "joshmedeski/sesh"
      "th-ch/youtube-music"
      "nikitabobko/tap"
      "nikitabobko/aerospace"
      "dhth/tap"
    ];

    brews = [
      "atuin"
      "dhth/tap/mult"
      "joshmedeski/sesh/sesh"

      # for neovim
      "sqlite"

      # TODO: move to home-manager
      "charmbracelet/tap/sequin"
      "dlvhdr/formulae/diffnav"
      "tailwindcss-language-server"
    ];

    casks = [
      "1password"
      "arc"
      "aws-vpn-client"
      "betterdisplay"
      "datagrip"
      "discord"
      "dockdoor"
      "docker"
      "figma"
      "font-commit-mono"
      "font-commit-mono-nerd-font"
      "font-dejavu-sans-mono-nerd-font"
      "font-fira-code-nerd-font"
      "font-symbols-only-nerd-font"
      "ghostty"
      "google-chrome"
      "hiddenbar"
      "homerow"
      "iina"
      "nikitabobko/tap/aerospace"
      "notion"
      "notion-calendar"
      "notunes"
      "obsidian"
      "raycast"
      "redis-insight"
      "slack"
      "stats"
      "th-ch/youtube-music/youtube-music"
      "ticktick"
      "visual-studio-code"
      "vivaldi"
      "whatsapp"
      "zoom"
    ];

    masApps = {
    };
  };
}
