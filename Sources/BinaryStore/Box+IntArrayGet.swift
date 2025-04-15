extension BinaryStore.Box {
    
    /// Get Array From Range
    // data:
    //   [UInt with bitWidth]
    public func getIntArray<T: FixedWidthInteger>(_ range: Range<Int>, intWidth: BinaryStore.BitWidth, sign: BinaryStore.Sign) -> [T] {
        
        switch T.bitWidth {
        case 8:
            return stride(from: range.lowerBound, to: range.upperBound, by: intWidth.rawValue).map { i in
                var result: T = 0
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                }
                return result
            }
        case 16:
            switch intWidth {
            case .bit8:
                return stride(from: range.lowerBound, to: range.upperBound, by: 1).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 1, as: UInt8.self)
                        }
                    }
                    return result
                }
            default:
                return stride(from: range.lowerBound, to: range.upperBound, by: intWidth.rawValue).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    }
                    return result
                }
            }
        case 32:
            switch intWidth {
            case .bit8:
                return stride(from: range.lowerBound, to: range.upperBound, by: 1).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 1, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit16:
                return stride(from: range.lowerBound, to: range.upperBound, by: 2).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 1] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit24:
                return stride(from: range.lowerBound, to: range.upperBound, by: 3).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 2] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                        }
                    }
                    return result
                }
            default:
                return stride(from: range.lowerBound, to: range.upperBound, by: intWidth.rawValue).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                    }
                    return result
                }
            }
        default:
            switch intWidth {
            case .bit8:
                return stride(from: range.lowerBound, to: range.upperBound, by: 1).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 1, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit16:
                return stride(from: range.lowerBound, to: range.upperBound, by: 2).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 1] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit24:
                return stride(from: range.lowerBound, to: range.upperBound, by: 3).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 2] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit32:
                return stride(from: range.lowerBound, to: range.upperBound, by: 4).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 3] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit40:
                return stride(from: range.lowerBound, to: range.upperBound, by: 5).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 4] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit48:
                return stride(from: range.lowerBound, to: range.upperBound, by: 6).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 5], toByteOffset: 5, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 5] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit56:
                return stride(from: range.lowerBound, to: range.upperBound, by: 7).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 5], toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 6], toByteOffset: 6, as: UInt8.self)
                        if T.isSigned && sign == .signed && p.pointee[i + 6] > Int8.max {
                            rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                        }
                    }
                    return result
                }
            case .bit64:
                return stride(from: range.lowerBound, to: range.upperBound, by: 8).map { i in
                    var result: T = 0
                    withUnsafeMutablePointer(to: &result) { ptr in
                        let rawPtr = UnsafeMutableRawPointer(ptr)
                        rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 5], toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 6], toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: p.pointee[i + 7], toByteOffset: 7, as: UInt8.self)
                    }
                    return result
                }
            }
        }
    }
}
