cask "subnetscout" do
  version "0.3.1"
  sha256 "3d8e1d95c46c647bf45d45dbe41b67ac77297b8c1ab2250bb4410157440963e2"

  url "https://github.com/massan71/SubnetScout/releases/download/v#{version}/SubnetScout-#{version}.zip"
  name "SubnetScout"
  desc "Network scanner with security audit and reports, powered by nmap"
  homepage "https://github.com/massan71/SubnetScout"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "nmap"
  depends_on macos: :sonoma

  app "SubnetScout.app"

  # The app is ad-hoc signed and not notarized: without this, Gatekeeper
  # refuses to open it after a download.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/SubnetScout.app"],
        must_succeed: false
  end

  uninstall quit: "net.sangalli.SubnetScout"

  # The optional privileged helper is registered by the app (SMAppService) and
  # goes away with it. Its protected copy of nmap lives in /Library.
  zap launchctl: "net.sangalli.SubnetScout.helper",
      delete:    "/Library/Application Support/SubnetScout",
      trash:     [
        "~/Library/Application Support/SubnetScout",
        "~/Library/Preferences/net.sangalli.SubnetScout.plist",
      ]

  caveats <<~EOS
    Scan only networks you own or are explicitly authorized to test.

    Install the privileged helper from the app sidebar ("Installa helper…") and
    approve SubnetScout in System Settings › General › Login Items & Extensions:
    every scan then runs through it, without password prompts or macOS local
    network limits. The app is not signed with an Apple Developer ID, so after
    each upgrade click "Reinstalla" and approve the helper again.
  EOS
end
