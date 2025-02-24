extension BinaryStore.Box: RandomAccessCollection {
    public func index(before i: Int) -> Int {
        return p.pointee.index(before: i)
    }
    
    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        return p.pointee.index(i, offsetBy: distance)
    }
}
