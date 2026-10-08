# Rendered by .github/workflows/release.yml (0.62.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository as
# Casks/lich.rb — edit this template, never the tap copy.
#
# A cask, not a formula: only a cask installs an .app into /Applications, which
# is what puts lich in Launchpad, in Spotlight and behind its own icon. The
# binary stanza keeps `lich` on PATH, so the one install still serves both.
cask "lich" do
  arch arm: "arm64", intel: "amd64"

  version "0.62.0"
  sha256 arm: "91e76a35aa604ab0f0dfdbc356d7ad72c4f883fbe5041b2c2d3edd3902cf174b", intel: "007de59ab37fc0320123d6768d72cecea0c1ba648587211b71e49ea0a3285d50"

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
