extension Slice: SortedCollectionProtocol
    where
    Base: SortedCollectionProtocol
{
    public typealias Key = Base.Key

    public func lowerBound(of value: Base.Key, in range: Range<Index>) -> Index {
        let range = self.startIndex..<self.endIndex
        return self.base.lowerBound(of: value, in: range)
    }

    public func upperBound(of value: Base.Key, in: Range<Base.Index>) -> Index {
        let range = self.startIndex..<self.endIndex
        return self.base.upperBound(of: value, in: range)
    }

    public func firstIndex(of value: Base.Key, in: Range<Base.Index>) -> Base.Index? {
        let range = self.startIndex..<self.endIndex
        return self.base.firstIndex(of: value, in: range)
    }

    public func range(of value: Base.Key, in: Range<Base.Index>) -> Range<Base.Index>? {
        let range = self.startIndex..<self.endIndex
        return self.base.range(of: value, in: range)
    }
}
