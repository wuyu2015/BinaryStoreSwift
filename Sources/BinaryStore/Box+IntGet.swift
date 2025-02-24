extension BinaryStore.Box {
    
    /// Get Int from offset
    public func getInt<T: FixedWidthInteger>(offset i: Int, intWidth: BinaryStore.BitWidth) -> T {
        
        var result: T = 0
        
        switch T.bitWidth {
        case 8:
            withUnsafeMutablePointer(to: &result) { ptr in
                let rawPtr = UnsafeMutableRawPointer(ptr)
                rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
            }
        case 16:
            switch intWidth {
            case .bit8:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    if T.isSigned && p.pointee[i] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 1, as: UInt8.self)
                    }
                }
            default:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                }
            }
        case 32:
            switch intWidth {
            case .bit8:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    if T.isSigned && p.pointee[i] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                    }
                }
            case .bit16:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 1] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                    }
                }
            case .bit24:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 2] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                    }
                }
            default:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                }
            }
        default:
            switch intWidth {
            case .bit8:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    if T.isSigned && p.pointee[i] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 1, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit16:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 1] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 2, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit24:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 2] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 3, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit32:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 3] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 4, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit40:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 4] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 5, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit48:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 5], toByteOffset: 5, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 5] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 6, as: UInt8.self)
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit56:
                withUnsafeMutablePointer(to: &result) { ptr in
                    let rawPtr = UnsafeMutableRawPointer(ptr)
                    rawPtr.storeBytes(of: p.pointee[i], toByteOffset: 0, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 1], toByteOffset: 1, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 2], toByteOffset: 2, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 3], toByteOffset: 3, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 4], toByteOffset: 4, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 5], toByteOffset: 5, as: UInt8.self)
                    rawPtr.storeBytes(of: p.pointee[i + 6], toByteOffset: 6, as: UInt8.self)
                    if T.isSigned && p.pointee[i + 6] > Int8.max {
                        rawPtr.storeBytes(of: 0xFF, toByteOffset: 7, as: UInt8.self)
                    }
                }
            case .bit64:
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
            }
        }
        
        return result
    }
}
