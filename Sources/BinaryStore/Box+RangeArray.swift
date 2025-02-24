extension BinaryStore.Box {
    
    // MARK: Get Range Array At Index

    // head:
    //   offsetWidth: offset
    //   sizeWidth: size
    public func getRangeArray<T: FixedWidthInteger>(index i: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, itemWidth: BinaryStore.BitWidth) -> [Range<T>] {
        let off: UInt64 = getInt(offset: i, itemWidth: offsetWidth)
        let sz: UInt64 = getInt(offset: i + offsetWidth.rawValue, itemWidth: sizeWidth)
        return getRangeArray(Int(off)..<Int(off + sz), itemWidth: itemWidth)
    }
    
    // head:
    //   offsetWidth: offset
    //   sizeWidth: size
    // data:
    //   itemWidth: lower
    //   itemWidth: upper
    //   ...
    //   ...
    // return: byte size of the range<T> array
    func setRangeArray<T: FixedWidthInteger>(_ rangeArr: [Range<T>], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, itemWidth: BinaryStore.BitWidth) -> Int {
        // set range array at offset
        let sz = setRangeArray(rangeArr, offset: offset, itemWidth: itemWidth)
        // set offset in head
        setInt(sz == 0 ? 0 : offset - index0, offset: index, itemWidth: offsetWidth)
        // set size in head
        setInt(sz, offset: index + offsetWidth.rawValue, itemWidth: sizeWidth)
        // return the size of range
        return sz
    }

    // MARK: To Range Array

    // head:
    //   offsetWidth: offset
    //   sizeWidth: size
    // data:
    //   itemWidth: lower
    //   itemWidth: upper
    //   ...
    //   ...
    public func toRangeArray<T: FixedWidthInteger>(itemWidth: BinaryStore.BitWidth) -> [Range<T>] {
        return getRangeArray(0..<p.pointee.count, itemWidth: itemWidth)
    }
}
