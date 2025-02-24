extension BinaryStore.Box {
    
    /// Set Int at offset
    public func setInt<T: FixedWidthInteger>(_ n: T, offset index: Int, itemWidth: BinaryStore.BitWidth) {
        let sz = index + itemWidth.rawValue
        if sz > p.pointee.count {
            p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
        }
        switch T.bitWidth {
        case 8:
            switch itemWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee[index + 1] = n < 0 ? 0xFF : 0
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee.replaceSubrange(index + 1...index + 2, with: repeatElement(n < 0 ? 0xFF : 0, count: 2))
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee.replaceSubrange(index + 1...index + 3, with: repeatElement(n < 0 ? 0xFF : 0, count: 3))
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee.replaceSubrange(index + 1...index + 4, with: repeatElement(n < 0 ? 0xFF : 0, count: 4))
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee.replaceSubrange(index + 1...index + 5, with: repeatElement(n < 0 ? 0xFF : 0, count: 5))
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee.replaceSubrange(index + 1...index + 6, with: repeatElement(n < 0 ? 0xFF : 0, count: 6))
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
                p.pointee.replaceSubrange(index + 1...index + 7, with: repeatElement(n < 0 ? 0xFF : 0, count: 7))
            }
        case 16:
            switch itemWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
                p.pointee[index + 2] = n < 0 ? 0xFF : 0
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
                p.pointee.replaceSubrange(index + 2...index + 3, with: repeatElement(n < 0 ? 0xFF : 0, count: 2))
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
                p.pointee.replaceSubrange(index + 2...index + 4, with: repeatElement(n < 0 ? 0xFF : 0, count: 3))
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
                p.pointee.replaceSubrange(index + 2...index + 5, with: repeatElement(n < 0 ? 0xFF : 0, count: 4))
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
                p.pointee.replaceSubrange(index + 2...index + 6, with: repeatElement(n < 0 ? 0xFF : 0, count: 5))
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
                p.pointee.replaceSubrange(index + 2...index + 7, with: repeatElement(n < 0 ? 0xFF : 0, count: 6))
            }
        case 32:
            switch itemWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                }
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                }
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                }
                p.pointee[index + 4] = n < 0 ? 0xFF : 0
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                }
                p.pointee.replaceSubrange(index + 4...index + 5, with: repeatElement(n < 0 ? 0xFF : 0, count: 2))
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                }
                p.pointee.replaceSubrange(index + 4...index + 6, with: repeatElement(n < 0 ? 0xFF : 0, count: 3))
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                }
                p.pointee.replaceSubrange(index + 4...index + 7, with: repeatElement(n < 0 ? 0xFF : 0, count: 4))
            }
        default:
            switch itemWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                }
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                }
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                    p.pointee[index + 4] = $0[4]
                }
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                    p.pointee[index + 4] = $0[4]
                    p.pointee[index + 5] = $0[5]
                }
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                    p.pointee[index + 4] = $0[4]
                    p.pointee[index + 5] = $0[5]
                    p.pointee[index + 6] = $0[6]
                }
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[index] = $0[0]
                    p.pointee[index + 1] = $0[1]
                    p.pointee[index + 2] = $0[2]
                    p.pointee[index + 3] = $0[3]
                    p.pointee[index + 4] = $0[4]
                    p.pointee[index + 5] = $0[5]
                    p.pointee[index + 6] = $0[6]
                    p.pointee[index + 7] = $0[7]
                }
            }
        }
    }
}
