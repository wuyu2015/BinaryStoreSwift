extension BinaryStore.Box {
    
    /// Get Range At Offset
    // data:
    //   type: lower
    //   type: upper
    public func getRange<T: FixedWidthInteger>(_ offset: Int, itemWidth: BinaryStore.BitWidth) -> Range<T> {
        return getInt(offset: offset, intWidth: itemWidth)..<getInt(offset: offset + itemWidth.rawValue, intWidth: itemWidth)
    }

    // data:
    //   type: lower
    //   type: upper
    public func toRange<T: FixedWidthInteger>(itemWidth: BinaryStore.BitWidth) -> Range<T> {
        return getRange(0, itemWidth: itemWidth)
    }
}
