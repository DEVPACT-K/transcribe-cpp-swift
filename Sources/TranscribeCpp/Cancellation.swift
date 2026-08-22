import CTranscribe
import os

/// A thread-safe cancellation flag. Install it on a `Session` with
/// `setCancellationToken`; the native abort callback (polled between decode
/// steps / chunks) reads it, so `cancel()` may be called from any thread to
/// abort an in-flight run/stream. The run then throws `.aborted` with the
/// partial transcript preserved.
public final class CancellationToken: @unchecked Sendable {
    private var _cancelled = false
    private let lock = NSLock()

    public init() {}

    public func cancel() { lock.lock(); defer { lock.unlock() }; _cancelled = true }
    public func reset() { lock.lock(); defer { lock.unlock() }; _cancelled = false }
    public var isCancelled: Bool { lock.lock(); defer { lock.unlock() }; return _cancelled }
}

/// C-ABI abort trampoline: reconstitutes the token from the userdata pointer
/// and reports its cancellation state. Fires on the native run thread.
private func abortTrampoline(_ userData: UnsafeMutableRawPointer?) -> Bool {
    guard let userData else { return false }
    return Unmanaged<CancellationToken>.fromOpaque(userData).takeUnretainedValue().isCancelled
}

extension Session {
    /// Install a cancellation token. The session keeps a strong reference; the
    /// C side holds an unretained pointer through the abort callback userdata.
    public func setCancellationToken(_ token: CancellationToken) {
        cancelToken = token
        let context = Unmanaged.passUnretained(token).toOpaque()
        transcribe_set_abort_callback(ptr, abortTrampoline, context)
    }

    /// Remove any installed cancellation token.
    public func clearCancellationToken() {
        transcribe_set_abort_callback(ptr, nil, nil)
        cancelToken = nil
    }
}
