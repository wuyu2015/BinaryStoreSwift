import Foundation

extension BinaryStore.Box {
    
    /// Set String Array At Offset
    // data header:
    //   countWidth: array length
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    //   ...
    //   ...
    // return: byte size of the sum of data header bytes and string array bytes
    public func setStringArray(_ strArr: [String], offset: Int, offset0: Int = 0, arrayWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth = .bit8, encoding: String.Encoding = .utf8) -> [Int] {
        let len = strArr.count
        if len == 0 {
            return []
        }
        // set the length of string array
        setInt(len, offset: offset, intWidth: arrayWidth)
        var offsets: [Int] = []
        offsets.reserveCapacity(len + 1)
        var off = offset + arrayWidth.rawValue
        if encoding == .utf16 {
            for s in strArr {
                offsets.append(off - offset0)
                let codes = s.utf16
                
                let sz = off + stringWidth.rawValue + (codes.count << 1)
                if sz > p.pointee.count {
                    p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
                }
                
                setInt(codes.count << 1, offset: off, intWidth: stringWidth)
                off += stringWidth.rawValue
                for code in codes {
                    p.pointee[off] = UInt8(truncatingIfNeeded: code >> 8)
                    p.pointee[off + 1] = UInt8(truncatingIfNeeded: code)
                    off += 2
                }
            }
        } else {
            for s in strArr {
                offsets.append(off)
                let codes = s.utf8
                
                let sz = off + stringWidth.rawValue + codes.count
                if sz > p.pointee.count {
                    p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
                }
                
                setInt(codes.count, offset: off, intWidth: stringWidth)
                off += stringWidth.rawValue
                for code in codes {
                    p.pointee[off] = code
                    off += 1
                }
            }
        }
        offsets.append(off - offset0)
        return offsets
    }
}
