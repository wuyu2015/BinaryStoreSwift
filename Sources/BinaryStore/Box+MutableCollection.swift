extension BinaryStore.Box: MutableCollection {
    public var startIndex: Int {
        return p.pointee.startIndex
    }
    
    public var endIndex: Int {
        return p.pointee.endIndex
    }
    
    public subscript(position: Int) -> UInt8 {
        get {
            return p.pointee[position]
        }
        set {
            p.pointee[position] = newValue
        }
    }
    
    public func index(after i: Int) -> Int {
        return p.pointee.index(after: i)
    }
}
