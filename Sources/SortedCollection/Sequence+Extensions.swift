extension Sequence
    where
        Element: Comparable
{
    public func isSorted() -> Bool {
        return self.isSorted { $0 < $1 }
    }
}

extension Sequence {
    public func isSorted(
        by areInIncreasingOrder: (Element, Element) throws -> Bool
    ) rethrows -> Bool {
        return try self.isSorted(
            for: \.self,
            by: areInIncreasingOrder
        )
    }
}

extension Sequence {
    public func isSorted<Key>(
        for keyPath: KeyPath<Element, Key>,
        by areInIncreasingOrder: (Key, Key) throws -> Bool
    ) rethrows -> Bool {
        var iterator = self.makeIterator()
        
        guard let element = iterator.next() else {
            return true
        }
        
        var previous = element[keyPath: keyPath]
        
        while let element = iterator.next() {
            let current = element[keyPath: keyPath]
            if try areInIncreasingOrder(current, previous) {
                return false
            }
            previous = current
        }
        
        return true
    }
}
