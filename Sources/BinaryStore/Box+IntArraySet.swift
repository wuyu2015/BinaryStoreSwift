extension BinaryStore.Box {
    
    /// Set Array at offset
    // data:
    //   [UInt with itemWidth]
    // return: byte size of the int array
    @discardableResult
    public func setIntArray<T: FixedWidthInteger>(_ intArr: [T], offset: Int, itemWidth: BinaryStore.BitWidth) -> Int {
        let sz = offset + itemWidth.rawValue * intArr.count
        if sz > p.pointee.count {
            p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
        }

        var i = offset
        switch T.bitWidth {
        case 8:
            switch itemWidth {
            case .bit8:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                    }
                    i += 1
                }
            case .bit16:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = n < 0 ? 0xFF : 0
                    }
                    i += 2
                }
            case .bit24:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                    }
                    i += 3
                }
            case .bit32:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                    }
                    i += 4
                }
            case .bit40:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                    }
                    i += 5
                }
            case .bit48:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    i += 6
                }
            case .bit56:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                    }
                    i += 7
                }
            case .bit64:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    i += 8
                }
            }
        case 16:
            switch itemWidth {
            case .bit8:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                    }
                    i += 1
                }
            case .bit16:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                    }
                    i += 2
                }
            case .bit24:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = n < 0 ? 0xFF : 0
                    }
                    i += 3
                }
            case .bit32:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                    }
                    i += 4
                }
            case .bit40:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                    }
                    i += 5
                }
            case .bit48:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    i += 6
                }
            case .bit56:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                    }
                    i += 7
                }
            case .bit64:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    i += 8
                }
            }
        case 32:
            switch itemWidth {
            case .bit8:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                    }
                    i += 1
                }
            case .bit16:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                    }
                    i += 2
                }
            case .bit24:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                    }
                    i += 3
                }
            case .bit32:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                    }
                    i += 4
                }
            case .bit40:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = n < 0 ? 0xFF : 0
                    }
                    i += 5
                }
            case .bit48:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    i += 6
                }
            case .bit56:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                    }
                    i += 7
                }
            case .bit64:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        let pad: UInt8 = n < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    i += 8
                }
            }
        default:
            switch itemWidth {
            case .bit8:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                    }
                    i += 1
                }
            case .bit16:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                    }
                    i += 2
                }
            case .bit24:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                    }
                    i += 3
                }
            case .bit32:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                    }
                    i += 4
                }
            case .bit40:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                    }
                    i += 5
                }
            case .bit48:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                        p.pointee[i + 5] = $0[5]
                    }
                    i += 6
                }
            case .bit56:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                        p.pointee[i + 5] = $0[5]
                        p.pointee[i + 6] = $0[6]
                    }
                    i += 7
                }
            case .bit64:
                for n in intArr {
                    withUnsafeBytes(of: n) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                        p.pointee[i + 5] = $0[5]
                        p.pointee[i + 6] = $0[6]
                        p.pointee[i + 7] = $0[7]
                    }
                    i += 8
                }
            }
        }
        return i - offset
    }
}
