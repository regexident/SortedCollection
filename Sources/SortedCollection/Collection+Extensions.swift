extension Collection
    where Element: Comparable & IdentityProtocol
{
    public func isSorted() -> Bool {
        return self.isSorted { $0 < $1 }
    }
}

extension Collection
    where Element: IdentityProtocol
{
    public func isSorted(
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Bool {
        return try self.isSorted(
            for: \.identity,
            by: areInIncreasingOrder
        )
    }
}

extension Collection {
    public func isSorted<Key>(
        for keyPath: KeyPath<Element, Key>,
        by areInIncreasingOrder: (Key, Key) throws -> Bool
    ) rethrows -> Bool {
        var previousIndex = self.startIndex
        var currentIndex = self.index(after: previousIndex)
        while currentIndex < self.endIndex {
            guard try !areInIncreasingOrder(
                self[currentIndex][keyPath: keyPath],
                self[previousIndex][keyPath: keyPath]
            ) else {
                return false
            }
            previousIndex = currentIndex
            currentIndex = self.index(after: currentIndex)
        }
        return true
    }
}
