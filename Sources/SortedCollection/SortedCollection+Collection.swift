extension SortedCollection: Collection {
    public typealias Element = Base.Element
    public typealias Index = Base.Index
    public typealias Iterator = Base.Iterator
    public typealias SubSequence = Slice<SortedCollection<Base, Key>>
    
    public var startIndex: Index {
        return self.base.startIndex
    }
    
    public var endIndex: Index {
        return self.base.endIndex
    }
    
    public func makeIterator() -> Iterator {
        return self.base.makeIterator()
    }
    
    public func index(after i: Base.Index) -> Base.Index {
        return self.base.index(after: i)
    }
    
    public subscript(position: Index) -> Element {
        return self.base[position]
    }
}
