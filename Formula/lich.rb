# Rendered by .github/workflows/release.yml (0.30.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository —
# edit this template, never the tap copy.
class Lich < Formula
  desc "Personal harness for AI-assisted development"
  homepage "https://github.com/omartelo/lich"
  version "0.30.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-arm64"
      sha256 "22037982a47535c6843235e1d18604da89a343171311a37a0bdee03a6915d1e1"
    end

    on_intel do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-amd64"
      sha256 "574b7c743cccf4ed6df6943a795b58ac75e3536aab8ec998e0ae9ff1c1079aa3"
    end
  end

  def install
    # The release ships bare binaries, so the staged file keeps the asset name.
    bin.install Dir["lich-v#{version}-darwin-*"].first => "lich"
  end

  def caveats
    <<~EOS
      lich opens its window in a Chromium-family browser and bundles none: install
      Google Chrome, Chromium, Microsoft Edge or Brave under /Applications.

      macOS support is experimental — see the project README.
    EOS
  end

  test do
    assert_predicate bin/"lich", :executable?
  end
end
