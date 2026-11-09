cask "isoquik" do
  version "1.2.1"
  sha256 "5d910fa4073776dec179c7a292ee72925d614b5b34ebfa38c041e6fef1e8a7b9"

  url "https://github.com/massan71/IsoQuik/releases/download/v#{version}/IsoQuik-#{version}.dmg"
  name "IsoQuik"
  desc "Write ISO and IMG images to USB drives and SD cards"
  homepage "https://github.com/massan71/IsoQuik"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "IsoQuik.app"

  # The app is ad-hoc signed and not notarized: without this, Gatekeeper
  # refuses to open it after a download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/IsoQuik.app"]
  end

  zap trash: [
    "~/Library/Preferences/local.isoquik.plist",
    "~/Library/Saved Application State/local.isoquik.savedState",
  ]
end
