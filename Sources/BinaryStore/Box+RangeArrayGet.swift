extension BinaryStore.Box {
    
    /// Get Range Array From Offset Range
    // data:
    //   rangeWidth: lower
    //   rangeWidth: upper
    //   ...
    //   ...
    public func getRangeArray<T: FixedWidthInteger>(_ range: Range<Int>, rangeWidth: BinaryStore.BitWidth, sign: BinaryStore.Sign) -> [Range<T>] {
        switch rangeWidth {
        case .bit8:
            return stride(from: range.lowerBound, to: range.upperBound, by: 2).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 1, intWidth: rangeWidth, sign: sign)
            }
        case .bit16:
            return stride(from: range.lowerBound, to: range.upperBound, by: 4).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 2, intWidth: rangeWidth, sign: sign)
            }
        case .bit24:
            return stride(from: range.lowerBound, to: range.upperBound, by: 6).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 3, intWidth: rangeWidth, sign: sign)
            }
        case .bit32:
            return stride(from: range.lowerBound, to: range.upperBound, by: 8).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 4, intWidth: rangeWidth, sign: sign)
            }
        case .bit40:
            return stride(from: range.lowerBound, to: range.upperBound, by: 10).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 5, intWidth: rangeWidth, sign: sign)
            }
        case .bit48:
            return stride(from: range.lowerBound, to: range.upperBound, by: 12).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 6, intWidth: rangeWidth, sign: sign)
            }
        case .bit56:
            return stride(from: range.lowerBound, to: range.upperBound, by: 14).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 7, intWidth: rangeWidth, sign: sign)
            }
        case .bit64:
            return stride(from: range.lowerBound, to: range.upperBound, by: 16).map { i in
                getInt(offset: i, intWidth: rangeWidth, sign: sign)..<getInt(offset: i + 8, intWidth: rangeWidth, sign: sign)
            }
        }
    }
}
