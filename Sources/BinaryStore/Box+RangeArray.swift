extension BinaryStore.Box {
    
    // MARK: Get Range Array At Index

    // head:
    //   offsetWidth: offset
    //   byteWidth: count of data bytes
    public func getRangeArray<T: FixedWidthInteger>(index i: Int, offsetWidth: BinaryStore.BitWidth = .bit32, byteWidth: BinaryStore.BitWidth = .bit32, rangeWidth: BinaryStore.BitWidth) -> [Range<T>] {
        let off: UInt64 = getInt(offset: i, intWidth: offsetWidth)
        let sz: UInt64 = getInt(offset: i + offsetWidth.rawValue, intWidth: byteWidth)
        return getRangeArray(Int(off)..<Int(off + sz), rangeWidth: rangeWidth)
    }
    
    // head:
    //   offsetWidth: offset
    //   byteWidth: size
    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    //   ...
    //   ...
    // return: byte size of the range<T> array
    @discardableResult
    func setRangeArray<T: FixedWidthInteger>(_ rangeArr: [Range<T>], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth = .bit32, byteWidth: BinaryStore.BitWidth = .bit32, rangeWidth: BinaryStore.BitWidth) -> Int {
        // set range array at offset
        let sz = setRangeArray(rangeArr, offset: offset, rangeWidth: rangeWidth)
        // set offset in head
        setInt(sz == 0 ? 0 : offset - index0, offset: index, intWidth: offsetWidth)
        // set size in head
        setInt(sz, offset: index + offsetWidth.rawValue, intWidth: byteWidth)
        // return the size of range
        return sz
    }

    // MARK: To Range Array

    // head:
    //   offsetWidth: offset
    //   byteWidth: size
    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    //   ...
    //   ...
    public func toRangeArray<T: FixedWidthInteger>(rangeWidth: BinaryStore.BitWidth) -> [Range<T>] {
        return getRangeArray(0..<p.pointee.count, rangeWidth: rangeWidth)
    }
}
