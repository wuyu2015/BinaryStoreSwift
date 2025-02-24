import Foundation

extension BinaryStore.Box {
    
    /// Set String At Offset
    // data:
    //   sizeWidth: size of string
    //   [UInt8]: string
    // return: total byte size
    public func setString(_ s: String, offset: Int, sizeWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> Int {
        var off = offset + sizeWidth.rawValue
        if encoding == .utf16 {
            let codes = s.utf16
            let strSz = codes.count << 1
            let sz = off + strSz

            if sz > p.pointee.count {
                p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
            }

            setInt(strSz, offset: offset, itemWidth: sizeWidth)
            for code in codes {
                p.pointee[off] = UInt8(truncatingIfNeeded: code >> 8)
                p.pointee[off + 1] = UInt8(truncatingIfNeeded: code)
                off += 2
            }
        } else {
            let codes = s.utf8
            let strSz = codes.count
            let sz = off + strSz

            if sz > p.pointee.count {
                p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
            }

            setInt(strSz, offset: offset, itemWidth: sizeWidth)
            for code in codes {
                p.pointee[off] = code
                off += 1
            }
        }
        return off - offset
    }
}
