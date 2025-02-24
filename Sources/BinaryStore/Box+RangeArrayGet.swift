extension BinaryStore.Box {
    
    /// Get Range Array From Offset Range
    // data:
    //   itemWidth: lower
    //   itemWidth: upper
    //   ...
    //   ...
    public func getRangeArray<T: FixedWidthInteger>(_ range: Range<Int>, itemWidth: BinaryStore.BitWidth) -> [Range<T>] {
        switch itemWidth {
        case .bit8:
            return stride(from: range.lowerBound, to: range.upperBound, by: 2).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 1, itemWidth: itemWidth)
            }
        case .bit16:
            return stride(from: range.lowerBound, to: range.upperBound, by: 4).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 2, itemWidth: itemWidth)
            }
        case .bit24:
            return stride(from: range.lowerBound, to: range.upperBound, by: 6).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 3, itemWidth: itemWidth)
            }
        case .bit32:
            return stride(from: range.lowerBound, to: range.upperBound, by: 8).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 4, itemWidth: itemWidth)
            }
        case .bit40:
            return stride(from: range.lowerBound, to: range.upperBound, by: 10).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 5, itemWidth: itemWidth)
            }
        case .bit48:
            return stride(from: range.lowerBound, to: range.upperBound, by: 12).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 6, itemWidth: itemWidth)
            }
        case .bit56:
            return stride(from: range.lowerBound, to: range.upperBound, by: 14).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 7, itemWidth: itemWidth)
            }
        case .bit64:
            return stride(from: range.lowerBound, to: range.upperBound, by: 16).map { i in
                getInt(i, itemWidth: itemWidth)..<getInt(i + 8, itemWidth: itemWidth)
            }
        }
    }
}
