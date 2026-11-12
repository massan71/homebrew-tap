cask "proxmoxdock" do
  version "1.2"
  sha256 "13417f0bcbd0a6d11f7526348f38155555646179ecb2a349e1ee850996478120"

  url "https://github.com/massan71/ProxmoxDock/releases/download/v#{version}/ProxmoxDock-#{version}.zip"
  name "ProxmoxDock"
  desc "Dock and menu bar app to monitor and manage Proxmox VE"
  homepage "https://github.com/massan71/ProxmoxDock"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "ProxmoxDock.app"

  # The app is ad-hoc signed and not notarized: without this, Gatekeeper
  # refuses to open it after a download.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/ProxmoxDock.app"],
        must_succeed: false
  end

  # The app keeps running in the Dock / menu bar, so quit it before upgrading or removing it
  uninstall quit: "local.proxmoxdock.app"

  # Sandboxed app: settings live in its container. The API token secret is in the login
  # Keychain ("ProxmoxDock" item) and is not removed by zap.
  zap trash: [
    "~/Library/Application Scripts/local.proxmoxdock.app",
    "~/Library/Containers/local.proxmoxdock.app",
  ]
end
