extension BinaryStore.Box {
    
    /// Get Range At Offset
    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    public func getRange<T: FixedWidthInteger>(offset: Int, rangeWidth: BinaryStore.BitWidth, sign: BinaryStore.Sign = .unsigned) -> Range<T> {
        return getInt(offset: offset, intWidth: rangeWidth, sign: sign)..<getInt(offset: offset + rangeWidth.rawValue, intWidth: rangeWidth, sign: sign)
    }

    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    public func toRange<T: FixedWidthInteger>(rangeWidth: BinaryStore.BitWidth, sign: BinaryStore.Sign = .unsigned) -> Range<T> {
        return getRange(offset: 0, rangeWidth: rangeWidth, sign: sign)
    }
}
