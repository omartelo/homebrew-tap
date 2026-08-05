# Rendered by .github/workflows/release.yml (0.26.1 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository —
# edit this template, never the tap copy.
class Lich < Formula
  desc "Personal harness for AI-assisted development"
  homepage "https://github.com/omartelo/lich"
  version "0.26.1"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-arm64"
      sha256 "bd4593ea4429263fa328166513748b6117d49982fbb4fe45e9c96c3789c2a4b6"
    end

    on_intel do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-amd64"
      sha256 "f83c04c2300c55a39e49ff08a5ffed852841cefefe9d79d885bcce6c0ef97731"
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
