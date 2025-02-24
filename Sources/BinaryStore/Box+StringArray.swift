import Foundation

extension BinaryStore.Box {
    
    // MARK: Get String Array At Index
    
    // header:
    //   offsetWidth: offset
    //   sizeWidth: size
    public func getStringArray(index: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth = .bit8, countWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> [String] {
        let sz: UInt64 = getInt(offset: index + offsetWidth.rawValue, itemWidth: sizeWidth)
        if sz == 0 {
            return []
        }
        let off: UInt64 = getInt(offset: index, itemWidth: offsetWidth)
        return getStringArray(offset: Int(off), countWidth: countWidth, stringWidth: sizeWidth, encoding: encoding)
    }
    
    
    // MARK: Set String Array At Index
    
    // head 1:
    //   offsetWidth: offset
    //   sizeWidth: size
    // head 2:
    //   offsetWidth: offset
    //   sizeWidth: size
    // data 1 header:
    //   countWidth: array length
    // data 1:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    //   ...
    //   ...
    // data 2:
    //   [offsetWidth] offsets
    public func setStringArray(_ strArr: [String], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth = .bit32, stringWidth: BinaryStore.BitWidth = .bit8, countWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8, needOffsets: Bool = false) -> Int {
        // set string array at offset
        let offsets = setStringArray(strArr, offset: offset, offset0: index0, countWidth: countWidth, stringWidth: stringWidth, encoding: encoding)
        let sz1 = offsets.isEmpty ? 0 : Int(offsets.last!) + index0 - offset
        // set offset in head 1
        setInt(sz1 == 0 ? 0 : offset - index0, offset: index, itemWidth: offsetWidth)
        // set size in head 1
        setInt(sz1, offset: index + offsetWidth.rawValue, itemWidth: stringWidth)
        if !needOffsets {
            return sz1
        }
        // set offsets array in head 2
        //setIntArray<T: FixedWidthInteger>(_ intArr: [T], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, itemWidth:
        let sz2 = setIntArray(offsets, index: index + offsetWidth.rawValue + stringWidth.rawValue, offset: offset + sz1, offsetWidth: offsetWidth, sizeWidth: stringWidth, itemWidth: offsetWidth)
        // return the sum of string array bytes and offsets array bytes
        return sz1 + sz2
    }
    
    // MARK: To String Array
    
    // data header:
    //   countWidth: array length
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    //   ...
    //   ...
    public func toStringArray(countWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth = .bit8, encoding: String.Encoding = .utf8) -> [String] {
        return getStringArray(offset: 0, countWidth: countWidth, stringWidth: stringWidth, encoding: encoding)
    }
}
