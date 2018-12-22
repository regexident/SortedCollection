public struct SortedCollection<Base: Collection, Key> {
    public internal(set) var base: Base
    public let keyPath: KeyPath<Base.Element, Key>
    public let areInIncreasingOrder: (Key, Key) -> Bool
}

extension SortedCollection
    where
        Base.Element: Comparable & IdentityProtocol,
        Key == Base.Element
{
    public init(sorted: Base) {
        self.init(
            sorted: sorted,
            for: \.identity,
            by: { $0 < $1 }
        )
    }
}

extension SortedCollection
    where Key: Comparable
{
    public init(
        sorted: Base,
        for keyPath: KeyPath<Base.Element, Key>
    ) {
        self.init(
            sorted: sorted,
            for: keyPath,
            by: { $0 < $1 }
        )
    }
}

extension SortedCollection {
    public init(
        sorted: Base,
        for keyPath: KeyPath<Base.Element, Key>,
        by areInIncreasingOrder: @escaping (Key, Key) -> Bool
    ) {
        // Expects elements in sorted order, similarly to how
        // Dictionary.init(uniqueKeysWithValues:) expects keys to be unique:
        assert(sorted.isSorted(for: keyPath, by: areInIncreasingOrder))
        
        self.init(
            base: sorted,
            keyPath: keyPath,
            areInIncreasingOrder: areInIncreasingOrder
        )
    }
}

extension SortedCollection
    where
        Base: MutableCollection & RandomAccessCollection,
        Base.Element: Comparable & IdentityProtocol,
        Key == Base.Element
{
    public init(sorting unsorted: Base) {
        self.init(
            sorting: unsorted,
            by: { $0 < $1 }
        )
    }
}

extension SortedCollection
    where
        Base: MutableCollection & RandomAccessCollection,
        Base.Element: IdentityProtocol,
        Key == Base.Element
{
    public init(
        sorting unsorted: Base,
        by areInIncreasingOrder: @escaping (Key, Key) -> Bool
    ) {
        self.init(
            sorting: unsorted,
            for: \.identity,
            by: areInIncreasingOrder
        )
    }
}

extension SortedCollection
    where
        Base: MutableCollection & RandomAccessCollection
{
    public init(
        sorting unsorted: Base,
        for keyPath: KeyPath<Base.Element, Key>,
        by areInIncreasingOrder: @escaping (Key, Key) -> Bool
    ) {
        var sorted = unsorted
        sorted.sort { lhs, rhs in
            areInIncreasingOrder(
                lhs[keyPath: keyPath],
                rhs[keyPath: keyPath]
            )
        }
        self.init(
            base: sorted,
            keyPath: keyPath,
            areInIncreasingOrder: areInIncreasingOrder
        )
    }
}
