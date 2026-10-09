# Rendered by .github/workflows/release.yml (0.64.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.64.0"
  sha256 arm: "cba0a0c591e03e9e3794eced37177068545093db8ded590cd06714e8c4660f44", intel: "d499b91f4b4352a07905d59054fbc0b0a4f23f027151686bfc9fe9d8e0b51f69"

  url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-#{arch}.zip"
  name "lich"
  desc "Terminal-first ADE for the coding agents you already use"
  homepage "https://github.com/omartelo/lich"

  depends_on macos: ">= :ventura"

  app "Lich.app"
  binary "#{appdir}/Lich.app/Contents/MacOS/lich"

  # lich is ad-hoc signed and never notarized, so Gatekeeper refuses a
  # quarantined copy outright. The archive is pinned by the checksums above and
  # comes from the project's own release — that is the trust this trades on.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Lich.app"]
  end

  caveats <<~EOS
    The app brings its own window on Apple Silicon and Intel. Should the
    window fail to open, lich opens as a tab in your default browser instead
    and keeps running after the tab is closed, so stop it from the terminal
    or by signalling the process.

    macOS support is experimental — see the project README.
  EOS

  zap trash: [
    "~/Library/Application Support/lich",
  ]
end
