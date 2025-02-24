extension BinaryStore.Box {
    // MARK: Set Range At Offset

    // data:
    //   type: lower
    //   type: upper
    // return: the size of range
    public func setRange<T: FixedWidthInteger>(_ range: Range<T>, offset i: Int, rangeWidth: BinaryStore.BitWidth) -> Int {
//        if range.isEmpty {
//            return 0
//        }

        let sz = i + (rangeWidth.rawValue << 1)
        if sz > p.pointee.count {
            p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
        }

        let n0 = range.lowerBound
        let n1 = range.upperBound
        let pad0: UInt8 = n0 < 0 ? 0xFF : 0
        let pad1: UInt8 = n1 < 0 ? 0xFF : 0
        switch T.bitWidth {
        case 8:
            switch rangeWidth {
            case .bit8:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 1] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 2] = $0[0]
                }
                p.pointee[i + 3] = pad1
            case .bit24:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                p.pointee[i + 2] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 3] = $0[0]
                }
                p.pointee[i + 4] = pad1
                p.pointee[i + 5] = pad1
            case .bit32:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 4] = $0[0]
                }
                p.pointee[i + 5] = pad1
                p.pointee[i + 6] = pad1
                p.pointee[i + 7] = pad1
            case .bit40:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 5] = $0[0]
                }
                p.pointee[i + 6] = pad1
                p.pointee[i + 7] = pad1
                p.pointee[i + 8] = pad1
                p.pointee[i + 9] = pad1
            case .bit48:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 6] = $0[0]
                }
                p.pointee[i + 7] = pad1
                p.pointee[i + 8] = pad1
                p.pointee[i + 9] = pad1
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
            case .bit56:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                p.pointee[i + 6] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 7] = $0[0]
                }
                p.pointee[i + 8] = pad1
                p.pointee[i + 9] = pad1
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
                p.pointee[i + 12] = pad1
                p.pointee[i + 13] = pad1
            case .bit64:
                
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = pad0
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                p.pointee[i + 6] = pad0
                p.pointee[i + 7] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 8] = $0[0]
                }
                p.pointee[i + 9] = pad1
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
                p.pointee[i + 12] = pad1
                p.pointee[i + 13] = pad1
                p.pointee[i + 14] = pad1
                p.pointee[i + 15] = pad1
            }
        case 16:
            switch rangeWidth {
            case .bit8:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 1] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 2] = $0[0]
                    p.pointee[i + 3] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 3] = $0[0]
                    p.pointee[i + 4] = $0[1]
                }
                p.pointee[i + 5] = pad1
            case .bit32:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 4] = $0[0]
                    p.pointee[i + 5] = $0[1]
                }
                p.pointee[i + 6] = pad1
                p.pointee[i + 7] = pad1
            case .bit40:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 5] = $0[0]
                    p.pointee[i + 6] = $0[1]
                }
                p.pointee[i + 7] = pad1
                p.pointee[i + 8] = pad1
                p.pointee[i + 9] = pad1
            case .bit48:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 6] = $0[0]
                    p.pointee[i + 7] = $0[1]
                }
                p.pointee[i + 8] = pad1
                p.pointee[i + 9] = pad1
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
            case .bit56:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                p.pointee[i + 6] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 7] = $0[0]
                    p.pointee[i + 8] = $0[1]
                }
                p.pointee[i + 9] = pad1
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
                p.pointee[i + 12] = pad1
                p.pointee[i + 13] = pad1
            case .bit64:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = pad0
                p.pointee[i + 3] = pad0
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                p.pointee[i + 6] = pad0
                p.pointee[i + 7] = pad0
                
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 8] = $0[0]
                    p.pointee[i + 9] = $0[1]
                }
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
                p.pointee[i + 12] = pad1
                p.pointee[i + 13] = pad1
                p.pointee[i + 14] = pad1
                p.pointee[i + 15] = pad1
            }
        case 32:
            switch rangeWidth {
            case .bit8:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 1] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 2] = $0[0]
                    p.pointee[i + 3] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 3] = $0[0]
                    p.pointee[i + 4] = $0[1]
                    p.pointee[i + 5] = $0[2]
                }
            case .bit32:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 4] = $0[0]
                    p.pointee[i + 5] = $0[1]
                    p.pointee[i + 6] = $0[2]
                    p.pointee[i + 7] = $0[3]
                }
            case .bit40:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee[i + 4] = pad0
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 5] = $0[0]
                    p.pointee[i + 6] = $0[1]
                    p.pointee[i + 7] = $0[2]
                    p.pointee[i + 8] = $0[3]
                }
                p.pointee[i + 9] = pad1
            case .bit48:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 6] = $0[0]
                    p.pointee[i + 7] = $0[1]
                    p.pointee[i + 8] = $0[2]
                    p.pointee[i + 9] = $0[3]
                }
                p.pointee[i + 10] = pad1
                p.pointee[i + 11] = pad1
            case .bit56:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                p.pointee[i + 6] = pad0
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 7] = $0[0]
                    p.pointee[i + 8] = $0[1]
                    p.pointee[i + 9] = $0[2]
                    p.pointee[i + 10] = $0[3]
                }
                p.pointee[i + 11] = pad1
                p.pointee[i + 12] = pad1
                p.pointee[i + 13] = pad1
            case .bit64:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee[i + 4] = pad0
                p.pointee[i + 5] = pad0
                p.pointee[i + 6] = pad0
                p.pointee[i + 7] = pad0
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 8] = $0[0]
                    p.pointee[i + 9] = $0[1]
                    p.pointee[i + 10] = $0[2]
                    p.pointee[i + 11] = $0[3]
                }
                p.pointee[i + 12] = pad1
                p.pointee[i + 13] = pad1
                p.pointee[i + 14] = pad1
                p.pointee[i + 15] = pad1
            }
        default:
            switch rangeWidth {
            case .bit8:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 1] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 2] = $0[0]
                    p.pointee[i + 3] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 3] = $0[0]
                    p.pointee[i + 4] = $0[1]
                    p.pointee[i + 5] = $0[2]
                }
            case .bit32:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 4] = $0[0]
                    p.pointee[i + 5] = $0[1]
                    p.pointee[i + 6] = $0[2]
                    p.pointee[i + 7] = $0[3]
                }
            case .bit40:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 5] = $0[0]
                    p.pointee[i + 6] = $0[1]
                    p.pointee[i + 7] = $0[2]
                    p.pointee[i + 8] = $0[3]
                    p.pointee[i + 9] = $0[4]
                }
            case .bit48:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                    p.pointee[i + 5] = $0[5]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 6] = $0[0]
                    p.pointee[i + 7] = $0[1]
                    p.pointee[i + 8] = $0[2]
                    p.pointee[i + 9] = $0[3]
                    p.pointee[i + 10] = $0[4]
                    p.pointee[i + 11] = $0[5]
                }
            case .bit56:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                    p.pointee[i + 5] = $0[5]
                    p.pointee[i + 6] = $0[6]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 7] = $0[0]
                    p.pointee[i + 8] = $0[1]
                    p.pointee[i + 9] = $0[2]
                    p.pointee[i + 10] = $0[3]
                    p.pointee[i + 11] = $0[4]
                    p.pointee[i + 12] = $0[5]
                    p.pointee[i + 13] = $0[6]
                }
            case .bit64:
                withUnsafeBytes(of: n0) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                    p.pointee[i + 5] = $0[5]
                    p.pointee[i + 6] = $0[6]
                    p.pointee[i + 7] = $0[7]
                }
                withUnsafeBytes(of: n1) {
                    p.pointee[i + 8] = $0[0]
                    p.pointee[i + 9] = $0[1]
                    p.pointee[i + 10] = $0[2]
                    p.pointee[i + 11] = $0[3]
                    p.pointee[i + 12] = $0[4]
                    p.pointee[i + 13] = $0[5]
                    p.pointee[i + 14] = $0[6]
                    p.pointee[i + 15] = $0[7]
                }
            }
        }
        return rangeWidth.rawValue << 1
    }
}
