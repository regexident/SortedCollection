public protocol SortedCollectionProtocol: Collection
    where SubSequence: SortedCollectionProtocol
{
    associatedtype Key

    func lowerBound(of value: Key, in: Range<Index>) -> Index
    func upperBound(of value: Key, in: Range<Index>) -> Index
    func firstIndex(of value: Key, in: Range<Index>) -> Index?
    func range(of value: Key, in: Range<Index>) -> Range<Index>?
}

extension SortedCollectionProtocol {
    func lowerBound(of value: Key) -> Index {
        let range = self.startIndex..<self.endIndex
        return self.lowerBound(of: value, in: range)
    }
    
    public func upperBound(of value: Key) -> Index {
        let range = self.startIndex..<self.endIndex
        return self.upperBound(of: value, in: range)
    }
    
    public func firstIndex(of value: Key) -> Index? {
        let range = self.startIndex..<self.endIndex
        return self.firstIndex(of: value, in: range)
    }
    
    public func range(of value: Key) -> Range<Index>? {
        let range = self.startIndex..<self.endIndex
        return self.range(of: value, in: range)
    }
}
