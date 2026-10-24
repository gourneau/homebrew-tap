cask "aurora-glass" do
  version "0.1.5"
  sha256 "143a1b79251d9826fdb61c42500f2a46490340eb4548a05f0ed5f87825a2d43a"

  url "https://github.com/gourneau/aurora-glass/releases/download/v#{version}/AuroraGlass.dmg"
  name "Aurora Glass"
  desc "Live GPU fluid simulation painted across the menu bar"
  homepage "https://aurora.radiantmachines.com"

  livecheck do
    url :url
    strategy :github_latest
  end

  # `swift build` produces host-arch only, so this is an Apple silicon build.
  # Declaring it keeps an Intel Mac from installing something it cannot run.
  depends_on arch: :arm64
  # The app draws through the menu bar's transparency, which is macOS 26
  # behaviour, and Info.plist sets LSMinimumSystemVersion to match.
  depends_on macos: ">= :tahoe"

  app "AuroraGlass.app"

  # The `aurora` CLI ships inside the bundle, where nothing puts it on PATH.
  # Installing from the disk image therefore leaves `aurora busy` reporting
  # "command not found" even though the binary is present. This symlink is the
  # whole reason the cask is worth having over the DMG.
  binary "#{appdir}/AuroraGlass.app/Contents/MacOS/aurora"

  # It is a menu bar agent with no Dock icon, so an upgrade would otherwise
  # replace the bundle underneath a still-running copy.
  uninstall quit: "com.gourneau.AuroraGlass"

  zap trash: [
    "~/Library/Preferences/com.gourneau.AuroraGlass.plist",
    "~/Library/Application Support/AuroraGlass",
  ]

  caveats <<~EOS
    Aurora Glass has no Dock icon. Look for the sparkles in your menu bar.

    One setting decides whether you see anything at all:

      System Settings -> Menu Bar -> turn OFF "Show menu bar background"

    That makes the bar transparent so the aurora shows through, with your own
    menu bar text drawn on top. With it on, the bar stays opaque and hides the
    effect entirely. Check that Accessibility -> Display -> Reduce Transparency
    is off too.
  EOS
end
