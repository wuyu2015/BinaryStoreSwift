extension BinaryStore.Box {
    
    /// Set Int at offset
    public func setInt<T: FixedWidthInteger>(_ n: T, offset i: Int, intWidth: BinaryStore.BitWidth) {
        let sz = i + intWidth.rawValue
        if sz > p.pointee.count {
            p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
        }
        switch T.bitWidth {
        case 8:
            switch intWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee[i + 1] = n < 0 ? 0xFF : 0
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee.replaceSubrange(i + 1...i + 2, with: repeatElement(n < 0 ? 0xFF : 0, count: 2))
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee.replaceSubrange(i + 1...i + 3, with: repeatElement(n < 0 ? 0xFF : 0, count: 3))
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee.replaceSubrange(i + 1...i + 4, with: repeatElement(n < 0 ? 0xFF : 0, count: 4))
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee.replaceSubrange(i + 1...i + 5, with: repeatElement(n < 0 ? 0xFF : 0, count: 5))
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee.replaceSubrange(i + 1...i + 6, with: repeatElement(n < 0 ? 0xFF : 0, count: 6))
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
                p.pointee.replaceSubrange(i + 1...i + 7, with: repeatElement(n < 0 ? 0xFF : 0, count: 7))
            }
        case 16:
            switch intWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee[i + 2] = n < 0 ? 0xFF : 0
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee.replaceSubrange(i + 2...i + 3, with: repeatElement(n < 0 ? 0xFF : 0, count: 2))
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee.replaceSubrange(i + 2...i + 4, with: repeatElement(n < 0 ? 0xFF : 0, count: 3))
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee.replaceSubrange(i + 2...i + 5, with: repeatElement(n < 0 ? 0xFF : 0, count: 4))
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee.replaceSubrange(i + 2...i + 6, with: repeatElement(n < 0 ? 0xFF : 0, count: 5))
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
                p.pointee.replaceSubrange(i + 2...i + 7, with: repeatElement(n < 0 ? 0xFF : 0, count: 6))
            }
        case 32:
            switch intWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                }
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee[i + 4] = n < 0 ? 0xFF : 0
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee.replaceSubrange(i + 4...i + 5, with: repeatElement(n < 0 ? 0xFF : 0, count: 2))
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee.replaceSubrange(i + 4...i + 6, with: repeatElement(n < 0 ? 0xFF : 0, count: 3))
            case .bit64:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
                p.pointee.replaceSubrange(i + 4...i + 7, with: repeatElement(n < 0 ? 0xFF : 0, count: 4))
            }
        default:
            switch intWidth {
            case .bit8:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                }
            case .bit16:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                }
            case .bit24:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                }
            case .bit32:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                }
            case .bit40:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                }
            case .bit48:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                    p.pointee[i + 5] = $0[5]
                }
            case .bit56:
                withUnsafeBytes(of: n) {
                    p.pointee[i] = $0[0]
                    p.pointee[i + 1] = $0[1]
                    p.pointee[i + 2] = $0[2]
                    p.pointee[i + 3] = $0[3]
                    p.pointee[i + 4] = $0[4]
                    p.pointee[i + 5] = $0[5]
                    p.pointee[i + 6] = $0[6]
                }
            case .bit64:
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
            }
        }
    }
}
