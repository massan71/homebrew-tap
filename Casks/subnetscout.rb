cask "subnetscout" do
  version "0.2.2"
  sha256 "bc7a186a4fb47adedddb1cb9647581e1de35571c7e151d9018e366d29fe5b97c"

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

    For admin scans without a password prompt, enable "Come amministratore",
    click "Installa helper…" and approve SubnetScout in System Settings ›
    General › Login Items & Extensions. After an upgrade, click "Reinstalla"
    and approve it again (the build is ad-hoc signed).
  EOS
end
