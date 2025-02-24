import Foundation

extension BinaryStore.Box {
    
    // MARK: Get String At Index

    // head:
    //   offsetWidth: offset
    // data:
    //   type: size of string
    //   [UInt8]: string
    public func getString(index: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> String {
        let off: UInt64 = getInt(index, itemWidth: offsetWidth)
        return getString(Int(off), sizeWidth: sizeWidth, encoding: encoding)
    }

    // MARK: Set String At Index

    // head:
    //   offsetWidth: offset
    // data:
    //   type: size of string
    //   [UInt8]: string
    // return: total byte size
    public func setString(_ s: String, index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> Int {
        // set string at offset
        let sz = setString(s, offset: offset, sizeWidth: sizeWidth, encoding: encoding)
        // set offset in head
        setInt(sz == 0 ? 0 : offset - index0, offset: index, itemWidth: offsetWidth)
        // return the size of string bytes
        return sz
    }

    // MARK: To String

    // data:
    //   type: size of string
    //   [UInt8]: string
    public func toString(sizeWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> String {
        return getString(0, sizeWidth: sizeWidth, encoding: encoding)
    }
}
