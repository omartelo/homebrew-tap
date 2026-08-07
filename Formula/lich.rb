# Rendered by .github/workflows/release.yml (0.27.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository —
# edit this template, never the tap copy.
class Lich < Formula
  desc "Personal harness for AI-assisted development"
  homepage "https://github.com/omartelo/lich"
  version "0.27.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-arm64"
      sha256 "e3ec6d96810568614ea043d0281dddd3bbf302af7ce38682ca2958e52065bb1c"
    end

    on_intel do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-amd64"
      sha256 "60f510ec4b72c28242258aa2e9784d1e4fb900e3ab9bdcd7e4ae4f47a3ace417"
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
