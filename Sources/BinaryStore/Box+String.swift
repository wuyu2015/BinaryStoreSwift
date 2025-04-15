import Foundation

extension BinaryStore.Box {
    
    // MARK: Get String At Index

    // head:
    //   offsetWidth: offset
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    public func getString(index: Int, offsetWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth, encoding: String.Encoding) -> String {
        let off: Int = getInt(offset: index, intWidth: offsetWidth, sign: .unsigned)
        return getString(offset: off, stringWidth: stringWidth, encoding: encoding)
    }

    // MARK: Set String At Index

    // head:
    //   offsetWidth: offset
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    // return: total byte size
    @discardableResult
    public func setString(_ s: String, index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth, encoding: String.Encoding) -> Int {
        // set string at offset
        let sz = setString(s, offset: offset, stringWidth: stringWidth, encoding: encoding)
        // set offset in head
        setInt(sz == 0 ? 0 : offset - index0, offset: index, intWidth: offsetWidth)
        // return the size of string bytes
        return sz
    }

    // MARK: To String

    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    public func toString(stringWidth: BinaryStore.BitWidth, encoding: String.Encoding) -> String {
        return getString(offset: 0, stringWidth: stringWidth, encoding: encoding)
    }
}
