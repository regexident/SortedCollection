extension SortedCollection: SortedCollectionProtocol
    where
        Base: RandomAccessCollection,
        Base.Index: Strideable,
        Base.Index.Stride: SignedInteger
{
    /// Search for lower bound of `value` within `self`.
    ///
    /// - Complexity: O(`log2(collection.count)`).
    ///
    /// - Parameters:
    ///   - value: The value to search for
    ///   - range: The range to search within
    /// - Returns:
    ///   First index of the first `element` in `collection` for
    ///   which `element < value` evaluates to false or `nil` if `value` is not found.
    public func lowerBound(of value: Key, in range: Range<Index>) -> Index {
        var first = range.startIndex
        var index = first
        var count = range.startIndex.distance(to: range.endIndex)
        while count > 0 {
            index = first
            let step = count / 2
            index = index.advanced(by: step)
            let lhs = self[index][keyPath: self.keyPath]
            if self.areInIncreasingOrder(lhs, value) {
                first = self.index(after: index)
                count -= step + 1
            } else {
                count = step
            }
        }
        return first
    }
    
    /// Search for upper bound of `value` within `self`.
    ///
    /// - Complexity: O(`log2(collection.count)`).
    ///
    /// - Parameters:
    ///   - value: The value to search for
    ///   - range: The range to search within
    /// - Returns:
    ///   First index of the first `element` in `collection` for which
    ///   `element > value` evaluates to true or `nil` if `value` is not found.
    public func upperBound(of value: Key, in range: Range<Index>) -> Index {
        var first = range.startIndex
        var index = first
        var count = range.startIndex.distance(to: range.endIndex)
        while count > 0 {
            index = first
            let step = count / 2
            index = index.advanced(by: step)
            let rhs = self[index][keyPath: self.keyPath]
            if !self.areInIncreasingOrder(value, rhs) {
                first = self.index(after: index)
                count -= step + 1
            } else {
                count = step
            }
        }
        return first
    }
    
    /// Search for index of `value` within `self`.
    ///
    /// - Complexity: O(`log2(collection.count)`).
    ///
    /// - Parameters:
    ///   - value: The value to search for
    ///   - range: The range to search within
    /// - Returns:
    ///   First index of the first `element` in `collection` for which
    ///   `element == value` evaluates to true or `nil` if `value` is not found.
    public func firstIndex(of value: Key, in range: Range<Index>) -> Index? {
        let index = self.lowerBound(of: value)
        let isAtEnd = (index == self.endIndex)
        guard !isAtEnd else {
            return nil
        }
        let rhs = self[index][keyPath: self.keyPath]
        let isMismatch = self.areInIncreasingOrder(value, rhs)
        return (!isAtEnd && !isMismatch) ? index : nil
    }
    
    /// Search for lower bound of `value` within `self`.
    ///
    /// - Complexity: O(`log2(collection.count)`).
    ///
    /// - Parameters:
    ///   - value: The value to search for
    ///   - range: The range to search within
    /// - Returns:
    ///   First range of `element`s in `collection` for which
    ///   `element == value` evaluates to true or `nil` if `value` is not found.
    public func range(of value: Key, in range: Range<Index>) -> Range<Index>? {
        guard let startIndex = self.firstIndex(of: value, in: range) else {
            return nil
        }
        let range = startIndex..<range.endIndex
        let endIndex = self[range].upperBound(of: value)
        return startIndex..<endIndex
    }
}
