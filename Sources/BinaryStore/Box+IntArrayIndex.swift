extension BinaryStore.Box {
    
    /// Get Array From Index
    // head:
    //   offsetWidth: off
    //   sizeWidth: sz
    // data:
    //   [UInt8 with itemWidth]
    public func getIntArray<T: FixedWidthInteger>(index i: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, itemWidth: BinaryStore.BitWidth) -> [T] {
        let off: UInt64 = getInt(i, itemWidth: offsetWidth)
        let sz: UInt64 = getInt(i + offsetWidth.rawValue, itemWidth: sizeWidth)
        return getIntArray(Int(off)..<Int(off) + Int(sz), itemWidth: itemWidth)
    }
    
    /// Set Array At Index
    // head:
    //   offsetWidth: off
    //   sizeWidth: sz
    // data:
    //   [UInt8 with itemWidth]
    // return: byte size of the int array
    @discardableResult
    public func setIntArray<T: FixedWidthInteger>(_ intArr: [T], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, itemWidth: BinaryStore.BitWidth) -> Int {
        let sz = setIntArray(intArr, offset: offset, itemWidth: itemWidth)
        // set offset at index
        setInt(sz == 0 ? 0 : offset - index0, offset: index, itemWidth: offsetWidth)
        // set size at index
        setInt(sz, offset: index + offsetWidth.rawValue, itemWidth: sizeWidth)
        // return the byte size of the int array
        return sz
    }

    /// To Array
    // data:
    //   [UInt8 with itemWidth]
    public func toIntArray<T: FixedWidthInteger>(itemWidth: BinaryStore.BitWidth) -> [T] {
        return getIntArray(0..<p.pointee.count, itemWidth: itemWidth)
    }
}
