# Rendered by .github/workflows/release.yml (0.46.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.46.0"
  sha256 arm: "ca8b22cf5b0268f7d21cdba8f18de4ccb0186e4ddfbdfd93798c9e39d1a71bb1", intel: "fe44271e85f784b7fee4b02dafa9a42d242dee41a39331b17560ed0451824497"

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
