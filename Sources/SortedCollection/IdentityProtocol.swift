// This is a workaround for the lack of support of `\.self` in key paths in Swift 4:

/// A type that provides an identity.
public protocol IdentityProtocol {

    /// Returns `self`
    var identity: Self { get }
}

extension IdentityProtocol {
    public var identity: Self {
        return self
    }
}
