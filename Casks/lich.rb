# Rendered by .github/workflows/release.yml (0.48.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.48.0"
  sha256 arm: "369cd63decce96fc17fab5f0094c4c24011dc819b2348df77ba1ef18e4b397d9", intel: "02c70c73db05bb100e45c30bdb9c20c81efe6a0ad3384d8bbc46a27579a907f9"

  url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-#{arch}.zip"
  name "lich"
  desc "Personal harness for AI-assisted development"
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
    On Apple Silicon the app brings its own window. On Intel lich opens its
    window in a Chromium-family browser and bundles none: install Google
    Chrome, Chromium, Microsoft Edge or Brave under /Applications. That window
    belongs to the browser, so the Dock shows the browser's icon while lich is
    running; the lich icon is the one in /Applications.

    macOS support is experimental — see the project README.
  EOS

  zap trash: [
    "~/Library/Application Support/lich",
  ]
end
