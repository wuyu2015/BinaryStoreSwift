extension BinaryStore.Box {
    
    // MARK: Set Range Array At Offset

    // data:
    //   itemWidth: lower
    //   itemWidth: upper
    //   ...
    //   ...
    // return: byte size of the range<T> array
    func setRangeArray<T: FixedWidthInteger>(_ rangeArr: [Range<T>], offset: Int, itemWidth: BinaryStore.BitWidth) -> Int {
        if rangeArr.isEmpty {
            return 0
        }
        let sz = offset + (itemWidth.rawValue << 1) * rangeArr.count
        if sz > p.pointee.count {
            p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
        }

        var i = offset
        switch T.bitWidth {
        case 8:
            switch itemWidth {
            case .bit8:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 1] = $0[0]
                    }
                    i += 2
                }
            case .bit16:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = n.lowerBound < 0 ? 0xFF : 0
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 2] = $0[0]
                        p.pointee[i + 3] = n.upperBound < 0 ? 0xFF : 0
                    }
                    i += 4
                }
            case .bit24:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 3] = $0[0]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    i += 6
                }
            case .bit32:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 4] = $0[0]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    i += 8
                }
            case .bit40:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 5] = $0[0]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                        p.pointee[i + 8] = pad
                        p.pointee[i + 9] = pad
                    }
                    i += 10
                }
            case .bit48:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 6] = $0[0]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 7] = pad
                        p.pointee[i + 8] = pad
                        p.pointee[i + 9] = pad
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                    }
                    i += 12
                }
            case .bit56:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 7] = $0[0]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 8] = pad
                        p.pointee[i + 9] = pad
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                        p.pointee[i + 12] = pad
                        p.pointee[i + 13] = pad
                    }
                    i += 14
                }
            case .bit64:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 1] = pad
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 8] = $0[0]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 9] = pad
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                        p.pointee[i + 12] = pad
                        p.pointee[i + 13] = pad
                        p.pointee[i + 14] = pad
                        p.pointee[i + 15] = pad
                    }
                    i += 16
                }
            }
        case 16:
            switch itemWidth {
            case .bit8:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 1] = $0[0]
                    }
                    i += 2
                }
            case .bit16:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 2] = $0[0]
                        p.pointee[i + 3] = $0[1]
                    }
                    i += 4
                }
            case .bit24:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = n.lowerBound < 0 ? 0xFF : 0
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 3] = $0[0]
                        p.pointee[i + 4] = $0[1]
                        p.pointee[i + 5] = n.upperBound < 0 ? 0xFF : 0
                    }
                    i += 6
                }
            case .bit32:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 4] = $0[0]
                        p.pointee[i + 5] = $0[1]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    i += 8
                }
            case .bit40:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 5] = $0[0]
                        p.pointee[i + 6] = $0[1]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 7] = pad
                        p.pointee[i + 8] = pad
                        p.pointee[i + 9] = pad
                    }
                    i += 10
                }
            case .bit48:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 6] = $0[0]
                        p.pointee[i + 7] = $0[1]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 8] = pad
                        p.pointee[i + 9] = pad
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                    }
                    i += 12
                }
            case .bit56:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 7] = $0[0]
                        p.pointee[i + 8] = $0[1]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 9] = pad
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                        p.pointee[i + 12] = pad
                        p.pointee[i + 13] = pad
                    }
                    i += 14
                }
            case .bit64:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 2] = pad
                        p.pointee[i + 3] = pad
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 8] = $0[0]
                        p.pointee[i + 9] = $0[1]
                        let pad: UInt8 = n.upperBound < 0 ? 0xFF : 0
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                        p.pointee[i + 12] = pad
                        p.pointee[i + 13] = pad
                        p.pointee[i + 14] = pad
                        p.pointee[i + 15] = pad
                    }
                    i += 16
                }
            }
        case 32:
            switch itemWidth {
            case .bit8:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 1] = $0[0]
                    }
                    i += 2
                }
            case .bit16:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 2] = $0[0]
                        p.pointee[i + 3] = $0[1]
                    }
                    i += 4
                }
            case .bit24:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 3] = $0[0]
                        p.pointee[i + 4] = $0[1]
                        p.pointee[i + 5] = $0[2]
                    }
                    i += 6
                }
            case .bit32:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 4] = $0[0]
                        p.pointee[i + 5] = $0[1]
                        p.pointee[i + 6] = $0[2]
                        p.pointee[i + 7] = $0[3]
                    }
                    i += 8
                }
            case .bit40:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = n.lowerBound < 0 ? 0xFF : 0
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 5] = $0[0]
                        p.pointee[i + 6] = $0[1]
                        p.pointee[i + 7] = $0[2]
                        p.pointee[i + 8] = $0[3]
                        p.pointee[i + 9] = n.upperBound < 0 ? 0xFF : 0
                    }
                    i += 10
                }
            case .bit48:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 6] = $0[0]
                        p.pointee[i + 7] = $0[1]
                        p.pointee[i + 8] = $0[2]
                        p.pointee[i + 9] = $0[3]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 10] = pad
                        p.pointee[i + 11] = pad
                    }
                    i += 12
                }
            case .bit56:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 7] = $0[0]
                        p.pointee[i + 8] = $0[1]
                        p.pointee[i + 9] = $0[2]
                        p.pointee[i + 10] = $0[3]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 11] = pad
                        p.pointee[i + 12] = pad
                        p.pointee[i + 13] = pad
                    }
                    i += 14
                }
            case .bit64:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 4] = pad
                        p.pointee[i + 5] = pad
                        p.pointee[i + 6] = pad
                        p.pointee[i + 7] = pad
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 8] = $0[0]
                        p.pointee[i + 9] = $0[1]
                        p.pointee[i + 10] = $0[2]
                        p.pointee[i + 11] = $0[3]
                        let pad: UInt8 = n.lowerBound < 0 ? 0xFF : 0
                        p.pointee[i + 12] = pad
                        p.pointee[i + 13] = pad
                        p.pointee[i + 14] = pad
                        p.pointee[i + 15] = pad
                    }
                    i += 16
                }
            }
        default:
            switch itemWidth {
            case .bit8:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 1] = $0[0]
                    }
                    i += 2
                }
            case .bit16:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 2] = $0[0]
                        p.pointee[i + 3] = $0[1]
                    }
                    i += 4
                }
            case .bit24:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 3] = $0[0]
                        p.pointee[i + 4] = $0[1]
                        p.pointee[i + 5] = $0[2]
                    }
                    i += 6
                }
            case .bit32:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 4] = $0[0]
                        p.pointee[i + 5] = $0[1]
                        p.pointee[i + 6] = $0[2]
                        p.pointee[i + 7] = $0[3]
                    }
                    i += 8
                }
            case .bit40:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 5] = $0[0]
                        p.pointee[i + 6] = $0[1]
                        p.pointee[i + 7] = $0[2]
                        p.pointee[i + 8] = $0[3]
                        p.pointee[i + 9] = $0[4]
                    }
                    i += 10
                }
            case .bit48:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                        p.pointee[i + 5] = $0[5]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 6] = $0[0]
                        p.pointee[i + 7] = $0[1]
                        p.pointee[i + 8] = $0[2]
                        p.pointee[i + 9] = $0[3]
                        p.pointee[i + 10] = $0[4]
                        p.pointee[i + 11] = $0[4]
                    }
                    i += 12
                }
            case .bit56:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                        p.pointee[i + 5] = $0[5]
                        p.pointee[i + 6] = $0[6]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 7] = $0[0]
                        p.pointee[i + 8] = $0[1]
                        p.pointee[i + 9] = $0[2]
                        p.pointee[i + 10] = $0[3]
                        p.pointee[i + 11] = $0[4]
                        p.pointee[i + 12] = $0[5]
                        p.pointee[i + 13] = $0[6]
                    }
                    i += 14
                }
            case .bit64:
                for n in rangeArr {
                    withUnsafeBytes(of: n.lowerBound) {
                        p.pointee[i] = $0[0]
                        p.pointee[i + 1] = $0[1]
                        p.pointee[i + 2] = $0[2]
                        p.pointee[i + 3] = $0[3]
                        p.pointee[i + 4] = $0[4]
                        p.pointee[i + 5] = $0[5]
                        p.pointee[i + 6] = $0[6]
                        p.pointee[i + 7] = $0[7]
                    }
                    withUnsafeBytes(of: n.upperBound) {
                        p.pointee[i + 8] = $0[0]
                        p.pointee[i + 9] = $0[1]
                        p.pointee[i + 10] = $0[2]
                        p.pointee[i + 11] = $0[3]
                        p.pointee[i + 12] = $0[4]
                        p.pointee[i + 13] = $0[5]
                        p.pointee[i + 14] = $0[6]
                        p.pointee[i + 15] = $0[7]
                    }
                    i += 16
                }
            }
        }
        return i - offset
    }
}
