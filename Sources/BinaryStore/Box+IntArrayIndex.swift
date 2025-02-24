extension BinaryStore.Box {
    
    /// Get Array From Index
    // head:
    //   offsetWidth: off
    //   byteWidth: size of data bytes
    // data:
    //   [UInt8 with intWidth]
    public func getIntArray<T: FixedWidthInteger>(index i: Int, offsetWidth: BinaryStore.BitWidth, byteWidth: BinaryStore.BitWidth, intWidth: BinaryStore.BitWidth) -> [T] {
        let off: UInt64 = getInt(offset: i, intWidth: offsetWidth)
        let sz: UInt64 = getInt(offset: i + offsetWidth.rawValue, intWidth: byteWidth)
        return getIntArray(Int(off)..<Int(off) + Int(sz), intWidth: intWidth)
    }
    
    /// Set Array At Index
    // head:
    //   offsetWidth: off
    //   byteWidth: size of data bytes
    // data:
    //   [UInt8 with intWidth]
    // return: byte size of the int array
    @discardableResult
    public func setIntArray<T: FixedWidthInteger>(_ intArr: [T], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, byteWidth: BinaryStore.BitWidth, intWidth: BinaryStore.BitWidth) -> Int {
        let sz = setIntArray(intArr, offset: offset, intWidth: intWidth)
        // set offset at index
        setInt(sz == 0 ? 0 : offset - index0, offset: index, intWidth: offsetWidth)
        // set size at index
        setInt(sz, offset: index + offsetWidth.rawValue, intWidth: byteWidth)
        // return the byte size of the int array
        return sz
    }

    /// To Array
    // data:
    //   [UInt8 with intWidth]
    public func toIntArray<T: FixedWidthInteger>(intWidth: BinaryStore.BitWidth) -> [T] {
        return getIntArray(0..<p.pointee.count, intWidth: intWidth)
    }
}
