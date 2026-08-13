# Rendered by .github/workflows/release.yml (0.32.0 -> tag, checksums from the
# release's checksums.txt) and pushed to the omartelo/homebrew-tap repository —
# edit this template, never the tap copy.
class Lich < Formula
  desc "Personal harness for AI-assisted development"
  homepage "https://github.com/omartelo/lich"
  version "0.32.0"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-arm64"
      sha256 "65f420e1f5c2fd8e778af50f83712951c042f1d2eb61bfdb8b96eba19be8291c"
    end

    on_intel do
      url "https://github.com/omartelo/lich/releases/download/v#{version}/lich-v#{version}-darwin-amd64"
      sha256 "c9d0c788a522088ea5523ddde81a3000e32f0485cefef0e5e996f415192b3330"
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
