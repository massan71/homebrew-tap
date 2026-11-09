# Homebrew tap for massan71

## IsoQuik

[IsoQuik](https://github.com/massan71/IsoQuik) writes ISO and IMG images to USB drives and SD cards on macOS (universal: Apple silicon and Intel, macOS 14 or later).

```bash
brew install --cask massan71/tap/isoquik
```

Update with `brew upgrade --cask isoquik`, remove with `brew uninstall --cask isoquik`.

IsoQuik is ad-hoc signed and not notarized by Apple. The cask removes the quarantine flag after installing, so macOS opens it without the Gatekeeper warning.

## Releasing a new IsoQuik version

1. Publish the release and its `IsoQuik-<version>.dmg` in the IsoQuik repository.
2. In `Casks/isoquik.rb`, update `version` and `sha256` (`shasum -a 256 IsoQuik-<version>.dmg`).
3. Check it: `brew audit --cask --online massan71/tap/isoquik && brew style massan71/tap`.
