cask "firewalladock" do
  version "1.4"
  sha256 "0308c7e9d579133a545d13a29b9ec17ba08e5ca24aef4bc3f2b0b85e93dd3420"

  url "https://github.com/massan71/FirewallaDock/releases/download/v#{version}/FirewallaDock-#{version}.zip"
  name "FirewallaDock"
  desc "Dock and menu bar monitor for Firewalla through the MSP API"
  homepage "https://github.com/massan71/FirewallaDock"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "FirewallaDock.app"

  # The app is ad-hoc signed and not notarized: without this, Gatekeeper
  # refuses to open it after a download.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/FirewallaDock.app"],
        must_succeed: false
  end

  # The app keeps running in the Dock / menu bar, so quit it before upgrading or removing it
  uninstall quit: "local.firewalladock.app"

  # Sandboxed app: settings live in its container. The API token is in the login Keychain
  # ("FirewallaDock" item) and is not removed by zap.
  zap trash: [
    "~/Library/Application Scripts/local.firewalladock.app",
    "~/Library/Containers/local.firewalladock.app",
  ]
end
