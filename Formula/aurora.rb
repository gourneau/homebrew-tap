class Aurora < Formula
  # Written by helper.sh on every release: the version and sha256 are those of
  # the archive it attached to that release. Edit this file in the app's repo,
  # never in the tap.
  desc "Command for Aurora Glass: lets coding agents and scripts set the menu bar aurora"
  homepage "https://auroraglass.app/helper.html"
  url "https://github.com/gourneau/aurora-glass/releases/download/v0.1.183/aurora-macos-0.1.183.zip"
  version "0.1.183"
  sha256 "fe8f4db12fb23cf38922c027534e484054c3621cb1f841813cce76ab4147af96"

  # The same binary that ships inside the direct download of Aurora Glass:
  # signed with Developer ID and covered by that build's notarization.
  # `swift build` produces host-arch only, so this is an Apple silicon build.
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "aurora"
  end

  def caveats
    <<~EOS
      This is the helper for the App Store version of Aurora Glass. If you
      installed Aurora Glass from auroraglass.app or with the aurora-glass
      cask, you already have this command and do not need the formula.

      Connect your agents (each line adds a hook to that agent's own settings):

        aurora hooks --install            # Claude Code
        aurora hooks --install --codex    # Codex
        aurora hooks --install --cursor   # Cursor
        aurora hooks --install --grok     # Grok

      Then, in Aurora Glass: Settings > Agents > Allow Access.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aurora --version")
  end
end
