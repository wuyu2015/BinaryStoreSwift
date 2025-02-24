extension BinaryStore.Box {
    
    /// Get Range Array From Offset Range
    // data:
    //   intWidth: lower
    //   intWidth: upper
    //   ...
    //   ...
    public func getRangeArray<T: FixedWidthInteger>(_ range: Range<Int>, itemWidth: BinaryStore.BitWidth) -> [Range<T>] {
        switch itemWidth {
        case .bit8:
            return stride(from: range.lowerBound, to: range.upperBound, by: 2).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 1, intWidth: itemWidth)
            }
        case .bit16:
            return stride(from: range.lowerBound, to: range.upperBound, by: 4).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 2, intWidth: itemWidth)
            }
        case .bit24:
            return stride(from: range.lowerBound, to: range.upperBound, by: 6).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 3, intWidth: itemWidth)
            }
        case .bit32:
            return stride(from: range.lowerBound, to: range.upperBound, by: 8).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 4, intWidth: itemWidth)
            }
        case .bit40:
            return stride(from: range.lowerBound, to: range.upperBound, by: 10).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 5, intWidth: itemWidth)
            }
        case .bit48:
            return stride(from: range.lowerBound, to: range.upperBound, by: 12).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 6, intWidth: itemWidth)
            }
        case .bit56:
            return stride(from: range.lowerBound, to: range.upperBound, by: 14).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 7, intWidth: itemWidth)
            }
        case .bit64:
            return stride(from: range.lowerBound, to: range.upperBound, by: 16).map { i in
                getInt(offset: i, intWidth: itemWidth)..<getInt(offset: i + 8, intWidth: itemWidth)
            }
        }
    }
}
