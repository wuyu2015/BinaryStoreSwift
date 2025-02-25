extension BinaryStore.Box {
    
    /// Get Range At Offset
    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    public func getRange<T: FixedWidthInteger>(offset: Int, rangeWidth: BinaryStore.BitWidth) -> Range<T> {
        return getInt(offset: offset, intWidth: rangeWidth)..<getInt(offset: offset + rangeWidth.rawValue, intWidth: rangeWidth)
    }

    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    public func toRange<T: FixedWidthInteger>(rangeWidth: BinaryStore.BitWidth) -> Range<T> {
        return getRange(offset: 0, rangeWidth: rangeWidth)
    }
}
