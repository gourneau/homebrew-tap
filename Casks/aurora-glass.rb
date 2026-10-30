cask "aurora-glass" do
  # Written by cask.sh on every release: version and sha256 come from the
  # live site's builds.txt, so the cask can only ever offer a build that is
  # actually downloadable. Edit this file in the app's repo, never in the tap.
  version "0.1.96"
  sha256 "47a4d34c0d5758dfad84f0c66ec224d06d23b816904c18b0a953103212968095"

  # Every published build stays on the site at its versioned name.
  url "https://aurora.radiantmachines.com/AuroraGlass-#{version}.dmg"
  name "Aurora Glass"
  desc "Living aurora for the menu bar, and a status light for AI agents"
  homepage "https://aurora.radiantmachines.com/"

  livecheck do
    url "https://aurora.radiantmachines.com/builds.txt"
    regex(/AuroraGlass[._-]v?(\d+(?:\.\d+)+)\.dmg/i)
  end

  # `swift build` produces host-arch only, so this is an Apple silicon build.
  # Declaring it keeps an Intel Mac from installing something it cannot run.
  depends_on arch: :arm64
  # The app draws through the menu bar's transparency, which is macOS 26
  # behaviour, and Info.plist sets LSMinimumSystemVersion to match.
  depends_on macos: :tahoe

  # The `aurora` CLI ships inside the bundle, where nothing puts it on PATH;
  # the binary link is the main reason to install through the cask.
  app "AuroraGlass.app"
  binary "#{appdir}/AuroraGlass.app/Contents/MacOS/aurora"

  # It is a menu bar agent with no Dock icon, so an upgrade would otherwise
  # replace the bundle underneath a still-running copy.
  uninstall quit: "com.gourneau.AuroraGlass"

  zap trash: [
    "~/Library/Application Support/AuroraGlass",
    "~/Library/Preferences/com.gourneau.AuroraGlass.plist",
  ]

  caveats <<~EOS
    Aurora Glass has no Dock icon. Look for its two arcs in your menu bar.

    One setting decides whether you see anything at all:

      System Settings -> Menu Bar -> turn OFF "Show menu bar background"

    To have your Claude Code agents drive it:

      aurora hooks --install
  EOS
end
