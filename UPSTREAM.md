# Upstream provenance

This package mirrors the official Swift bindings from
[`handy-computer/transcribe.cpp`](https://github.com/handy-computer/transcribe.cpp).

Current pin:

- Release: `v0.1.2`
- Source commit: `33d5c383e43e6acbd572845866ea75b8c7959fa5`
- Swift source path: `bindings/swift/Sources/TranscribeCpp`
- Swift test path: `bindings/swift/Tests/TranscribeCppTests`
- Asset: `TranscribeCpp.xcframework.zip`
- Asset SHA-256: `4092276cd295860ae9637a2913cf2d8747f39d454bb7fb3c79d6af9f858a4bb8`

`Sources/TranscribeCpp` and `Tests/TranscribeCppTests` are copied unchanged from
that tag. `Package.swift` is intentionally smaller than the upstream development
manifest: it replaces the local binary path with the published asset URL and
omits upstream examples.

## Updating

1. Check out the new upstream release tag.
2. Replace `Sources/TranscribeCpp`, `Tests/TranscribeCppTests`, `LICENSE`, and
   `THIRD-PARTY-LICENSES.md` from `bindings/swift` at that tag.
3. Update the release URL and `swift package compute-checksum` value in
   `Package.swift`.
4. Update the release, commit, and checksum above.
5. Run `swift package reset && scripts/test.sh` on macOS.
6. Confirm the XCFramework macOS binary contains both `arm64` and `x86_64`.
7. Tag this package with the matching semantic version only after all checks pass.
