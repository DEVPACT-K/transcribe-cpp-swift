# transcribe-cpp-swift

Swift Package Manager distribution of the official Swift bindings for
[transcribe.cpp](https://github.com/handy-computer/transcribe.cpp).

The package contains the tagged Swift wrapper source and references the matching
upstream release XCFramework by URL and checksum. It does not duplicate the
native binary in this repository.

## Install

```swift
dependencies: [
    .package(
        url: "https://github.com/altic-dev/transcribe-cpp-swift.git",
        exact: "0.1.2"
    ),
]
```

Add the product to your target:

```swift
.product(name: "TranscribeCpp", package: "transcribe-cpp-swift")
```

Then import the wrapper:

```swift
import TranscribeCpp

let model = try Model(path: "/path/to/model.gguf")
let transcript = try model.session().run(pcm)
print(transcript.text)
```

The binary supports macOS 13+ (`arm64` and `x86_64`) and iOS 16+.

## Test

```sh
scripts/test.sh
```

The helper stages the dynamic binary framework where SwiftPM's command-line
test runner expects it, then runs the official upstream test suite. Model-based
tests use the same optional `TRANSCRIBE_SMOKE_*` environment variables as
upstream; no-model ABI and runtime tests always run.

## Provenance

See [UPSTREAM.md](UPSTREAM.md) for the exact source commit, release asset, and
update procedure. The wrapper and native dependencies remain under their
upstream licenses; see [LICENSE](LICENSE) and
[THIRD-PARTY-LICENSES.md](THIRD-PARTY-LICENSES.md).
