# Homebrew tap for massan71

## IsoQuik

[IsoQuik](https://github.com/massan71/IsoQuik) writes ISO and IMG images to USB drives and SD cards on macOS (universal: Apple silicon and Intel, macOS 14 or later).

```bash
brew install --cask massan71/tap/isoquik
```

Naming the tap in the command trusts the cask, as Homebrew requires for third-party taps.
Update with `brew upgrade --cask isoquik`, remove with `brew uninstall --cask isoquik`.

IsoQuik is ad-hoc signed and not notarized by Apple. The cask removes the quarantine flag after installing, so macOS opens it without the Gatekeeper warning.

## FirewallaDock

[FirewallaDock](https://github.com/massan71/FirewallaDock) shows your Firewalla alarms, devices and rules in the Dock and menu bar through the Firewalla MSP API (universal: Apple silicon and Intel, macOS 14 or later).

```bash
brew install --cask massan71/tap/firewalladock
```

Update with `brew upgrade --cask firewalladock`, remove with `brew uninstall --cask firewalladock` (`--zap` also removes its settings; the API token stays in the Keychain under "FirewallaDock").

FirewallaDock is ad-hoc signed and not notarized by Apple. Like IsoQuik, the cask removes the quarantine flag after installing.

## SubnetScout

[SubnetScout](https://github.com/massan71/SubnetScout) scans your local network with nmap, audits the services it finds and exports HTML/CSV/JSON reports (universal: Apple silicon and Intel, macOS 14 or later). Installing it also installs the `nmap` formula.

```bash
brew install --cask massan71/tap/subnetscout
```

Update with `brew upgrade --cask subnetscout`, remove with `brew uninstall --cask subnetscout` (`--zap` also removes scan history, settings, the privileged helper and its protected copy of nmap).

SubnetScout is signed with its own certificate (not an Apple Developer ID) and is not notarized. Like the other apps here, the cask removes the quarantine flag after installing. After an upgrade, the privileged helper has to be reinstalled and approved again from the app.

## ProxmoxDock

[ProxmoxDock](https://github.com/massan71/ProxmoxDock) monitors and manages a Proxmox VE server or cluster from the Dock and menu bar: nodes, VMs and containers, power actions, snapshots and backups (universal: Apple silicon and Intel, macOS 14 or later).

```bash
brew install --cask massan71/tap/proxmoxdock
```

Update with `brew upgrade --cask proxmoxdock`, remove with `brew uninstall --cask proxmoxdock` (`--zap` also removes its settings; the API token secret stays in the Keychain under "ProxmoxDock").

ProxmoxDock is ad-hoc signed and not notarized by Apple; like the other casks here, it removes the quarantine flag after installing.

## Releasing a new IsoQuik version

1. Publish the release and its `IsoQuik-<version>.dmg` in the IsoQuik repository.
2. In `Casks/isoquik.rb`, update `version` and `sha256` (`shasum -a 256 IsoQuik-<version>.dmg`).
3. Check it: `brew audit --cask --online massan71/tap/isoquik && brew style massan71/tap`.

## Releasing a new FirewallaDock version

`scripts/release.sh` in the FirewallaDock repository updates `Casks/firewalladock.rb` here (version and `sha256`), commits and pushes it after publishing the GitHub release, as long as this repository is checked out next to it. To do it by hand: update `version` and `sha256` (`shasum -a 256 FirewallaDock-<version>.zip`), then `brew audit --cask --online massan71/tap/firewalladock && brew style massan71/tap`.

## Releasing a new SubnetScout version

`scripts/release.sh` in the SubnetScout repository updates `Casks/subnetscout.rb` here (version and `sha256`), commits and pushes it after publishing the GitHub release, as long as this repository is checked out next to it. To do it by hand: update `version` and `sha256` (`shasum -a 256 SubnetScout-<version>.zip`), then `brew audit --cask --online massan71/tap/subnetscout && brew style massan71/tap`.

## Releasing a new ProxmoxDock version

`scripts/release.sh` in the ProxmoxDock repository updates `Casks/proxmoxdock.rb` here (version and `sha256`), commits and pushes it after publishing the GitHub release, as long as this repository is checked out next to it.
