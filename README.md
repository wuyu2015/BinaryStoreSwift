# BinaryStore  

`BinaryStore` is a Swift Package designed for creating custom binary data structures. It provides developers with a flexible toolkit for building and manipulating binary file formats, with a focus on minimizing storage space.  

When analyzing third-party binary data files, you may notice that gaps between data are filled with zero bytes. This is often caused by fixed-width integers (`FixedWidthInteger`), leading to significant space waste. To address this, `BinaryStore` supports not only standard 8-bit, 16-bit, 32-bit, and 64-bit integers but also non-standard 24-bit, 40-bit, 48-bit, and 56-bit integers. By leveraging these, you can reduce unnecessary zero bytes and optimize data size. 

For applications where minimizing network data size is critical, consider using custom binary data instead of JSON strings. Besides compression algorithms, eliminating redundant data bits is also an important optimization strategy. Packing multiple values into a single byte further optimizes storage. At the language level, bitwise operators already provide the necessary tools for this. Once you have such an integer, you might need to store it in a file or transmit it over a network—this is where a 24-bit or 40-bit integer could come in handy.

Additionally, `BinaryStore` maintains O(1) read/write efficiency, close to native array operations in performance.

The following code example demonstrates simple cases of storing `Int`, `Int` arrays, `String`, `String` arrays, `Range`, and `Range` arrays in binary. In practical scenarios, these data types are often stored in a mixed manner, usually corresponding to a Swift `Struct`. This kind of code needs to be written by you. In the source code, there are functions that support plist storage, but using plist to support binary storage is not the main goal of `BinaryStore`, so they are not provided in the demo code. Support for floating-point numbers is not yet implemented but may be added in future versions.

## Getting Started  

### Initializing `BinaryStore.box`  

```swift
import BinaryStore

// `buf` can be any collection of UInt8,
// for example: Array<UInt8>, Data, UnsafeMutablePointer<UInt8>, or UnsafeBufferPointer<UInt8> …
var buf: [UInt8] = []
let box = BinaryStore.Box(bytes: &buf)
```

### Integer  

```swift
// Store the number using 1 byte
box.setInt(123, offset: 0)

// Store the number using 2 bytes
box.setInt(65535, offset: 1, intWidth: .bit16)

// Store 65536 using 3 bytes
box.setInt(65536, offset: 3, intWidth: .bit24)

// Store a mainland China phone number using 5 bytes
box.setInt(13888888888, offset: 6, intWidth: .bit40)

// A total of 11 bytes are used
print(box.count) // Output: 11
```

The bytes of `buf` are now as follows (Little Endian):  

| Address | Byte Value | Description |
|-|-|-|
|-|-|-|
| 0 | 0x7B | 123 |
| 1 | 0xFF | 65535 |
| 2 | 0xFF | |
| 3 | 0x00 | 65536 |
| 4 | 0x00 | |
| 5 | 0x01 | |
| 6 | 0x33 | 13888888888 |
| 7 | 0xBD | |
| 8 | 0x7A | |
| 9 | 0x03 | |
| 10 | 0x08 | |

```swift
// Read as Integer
let n1: UInt8 = box.getInt(offset: 0)
let n2: UInt16 = box.getInt(offset: 1, intWidth: .bit16)
let n3 UInt32 = box.getInt(offset: 3, intWidth: .bit24)
let n4: Int = box.getInt(offset: 6, intWidth: .bit40)
```

### Integer Arrays  

```swift
// Prepare data
let arr: [Int8] = [1, 2, 3, 4, -1, -2, -3, -4]

// Store the array
box.setIntArray(arr, index: 10, offset: 1024 * 64, arrayWidth: .bit8, intWidth: .bit8)
```

> Parameter description:  
> 1. `index`: Index address  
> 2. `offset`: Data address  
> 3. `arrayWidth`: Array length width  
> 4. `intWidth`: Integer width  

The bytes of `buf` are now as follows (Little Endian):  

| Address | Byte Value | Meaning | Description |
|-|-|-|-|
| ... | 0x0 | | Unused |
| 10 | 0x0 | 65536 | Data address (stored in 4 bytes) |
| 11 | 0x0 | | |
| 12 | 0x1 | | |
| 13 | 0x0 | | |
| 14 | 0x8 | 8 | Data size (stored in 4 bytes) |
| 15 | 0x0 | | |
| 16 | 0x0 | | |
| 17 | 0x0 | | |
| ... | 0x0 | | Unused |
| 65536 | 0x1 | 1 | |
| 65537 | 0x2 | 2 | |
| 65538 | 0x3 | 3 | |
| 65539 | 0x4 | 4 | |
| 65540 | 0xFF | -1 or 255 | |
| 65541 | 0xFE | -2 or 254 | |
| 65542 | 0xFD | -3 or 253 | |
| 65543 | 0xFC | -4 or 252 | |


```swift
// Now, we read the array using the index value
let result1: [Int] = box.getIntArray(index: 10, offsetWidth: .bit32, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, -1, -2, -3, -4]  
print(result1)

// Read with [UInt8], negative numbers will be converted to the corresponding unsigned values
let result2: [UInt8] = box.getIntArray(index: 10, offsetWidth: .bit32, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result2)

// Read with [UInt32], note that it has the same effect as [UInt8]
let result3: [UInt32] = box.getIntArray(index: 10, offsetWidth: .bit32, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result3)
```

> Note: Ensuring the width types match is critical. Using different width types flexibly will make it difficult for others to incorrectly parse your binary files.


### String  

```swift
let s = "Hello world!"

// Store the string
box.setString(s, index: 0, offset: 100)
```

> Parameter Explanation:
> 1. `index`: Index address
> 2. `offset`: Data address

Now the bytes in `buf` are as follows (Little Endian):

| Address | Byte Value | Meaning | Description |
|-|-|-|-|
| 0 | 0x64 | 100 | Data address (stored in 4 bytes) |
| 1 | 0x0 | | |
| 2 | 0x0 | | |
| 3 | 0x0 | | |
| ... | 0x0 | | Unused |
| 100 | 0xC | 12 | String byte count (stored in 1 byte) |
| 101 | 0x48 | "H" | |
| 102 | 0x65 | "e" | |
| 103 | 0x6C | "l" | |
| 104 | 0x6C | "l" | |
| 105 | 0x6F | "o" | |
| 106 | 0x20 | " " | Space |
| 107 | 0x77 | "w" | |
| 108 | 0x6F | "o" | |
| 109 | 0x72 | "r" | |
| 110 | 0x6C | "l" | |
| 111 | 0x64 | "d" | |
| 112 | 0x21 | "!" | |

```swift
// Retrieve the string using index (0)
let s1 = box.getString(index: 0)

// Output: Hello world!
print(s1)

// Or retrieve the string directly using offset (100)
let s2 = box.getString(offset: 100)

// Output: Hello world!
print(s2)
```

### String Arrays  

```swift
let arr = ["Hello world!", "a", "ab", "abc"]

// Store the string array
box.setStringArray(arr, index: 0, offset: 100, offsetWidth: .bit16, byteWidth: .bit16, arrayWidth: .bit8, withArrayIndex: true)
```

> Parameter Explanation:
> 1. `index`: Index address
> 2. `offset`: Data address
> 3. `offsetWidth`: Data address width (default: `.bit32`)
> 4. `byteWidth`: Data byte size width (default: `.bit32`)
> 5. `arrayWidth`: Array length width (no default value)
> 6. `withArrayIndex`: Whether to generate an index for data addresses (default: `false`, meaning no index is generated)

Now the bytes in `buf` are as follows (Little Endian):

| Address | Byte Value | Meaning | Description |
|-|-|-|-|
| 0 | 0x64 | 100 | Data address (stored in 2 bytes) |
| 1 | 0x0 | | |
| 2 | 0x19 | 25 | Data byte size (stored in 2 bytes) |
| 3 | 0x0 | | |
| 4 | 0x7D | 125 | Index address (stored in 2 bytes) |
| 6 | 0x0 | | |
| 7 | 0x6 | 6 | Index byte size (stored in 2 bytes) |
| 8 | 0x0 | | |
| ... | 0x0 | | Unused |
| 100 | 0x4 | 4 | Array length (stored in 1 byte) |
| 101 | 0xC | 12 | Length of "Hello world!" (stored in 1 byte) |
| 102 | 0x48 | "H" | |
| 103 | 0x65 | "e" | |
| 104 | 0x6C | "l" | |
| 105 | 0x6C | "l" | |
| 106 | 0x6F | "o" | |
| 107 | 0x20 | " " | Space  |
| 108 | 0x77 | "w" | |
| 109 | 0x6F | "o" | |
| 110 | 0x72 | "r" | |
| 111 | 0x6C | "l" | |
| 112 | 0x64 | "d" | |
| 113 | 0x21 | "!" | |
| 114 | 0x1 | 1 | Length of "a" (stored in 1 byte) |
| 115 | 0x61 | "a" | |
| 116 | 0x2 | 2 | Length of "ab" (stored in 1 byte) |
| 117 | 0x61 | "a" | |
| 118 | 0x62 | "b" | |
| 119 | 0x3 | 3 | Length of "abc" (stored in 1 byte) |
| 120 | 0x61 | "a" | |
| 121 | 0x62 | "b" | |
| 122 | 0x63 | "c" | |
| 123 | 0x65 | 101 | Index start: Address of "Hello world!" (stored in 2 bytes) |
| 124 | 0x0 | | |
| 125 | 0x72 | 114 | Address of "a" (stored in 2 bytes) |
| 126 | 0x0 | | |
| 127 | 0x74 | 116 | Address of "ab" (stored in 2 bytes) |
| 128 | 0x0 | | |
| 129 | 0x79 | 119 | Address of "abc" (stored in 2 bytes) |
| 130 | 0x0 | | |

```swift
// Retrieve the string array using index (0)
let result1 = box.getStringArray(index: 0, offsetWidth: .bit16, byteWidth: .bit16, arrayWidth: .bit8)

// Output: ["Hello world!", "a", "ab", "abc"]
print(result1)

// Or retrieve the string array directly using offset (100)
let result2 = box.getStringArray(offset: 100, arrayWidth: .bit8)

// Output: ["Hello world!", "a", "ab", "abc"]
print(result2)
```

### Ranges  

```swift
let range = 0..<128

// Store the range
box.setRange(range, offset: 0, rangeWidth: .bit16)
```

Now, the bytes in `buf` are as follows (Little Endian):

| Address | Byte Value | Meaning | Description |
|-|-|-|-|
| 0 | 0x0 | 0 | `range` lowerBound |
| 1 | 0x0 | | |
| 2 | 0x80 | 128 | `range` upperBound |
| 3 | 0x0 | | |

```swift
// Retrieve the range directly using offset (0)
let result: Range<Int> = box.getRange(offset: 0, rangeWidth: .bit16)

// Output: 0..<128
print(result)
```

### Range Arrays  

```swift
let rangeArr: [Range<Int>] = [
    1..<128,
    256..<512,
    1024..<4096
]

// Store the range array
box.setRangeArray(rangeArr, index: 0, offset: 100, rangeWidth: .bit16)
```

| Address | Byte Value | Meaning | Description |
|-|-|-|-|
| 0 | 0x64 | 100 | Data address (stored in 4 bytes) |
| 1 | 0x0 | | |
| 2 | 0x0 | | |
| 3 | 0x0 | | |
| 4 | 0xD | 12 | Data size (stored in 4 bytes) |
| 5 | 0x0 | | |
| 6 | 0x0 | | |
| 7 | 0x0 | | |
| ... | 0x0 | | Unused |
| 100 | 0x0 | 0 | `rangeArr[0]` lowerBound |
| 101 | 0x0 | | |
| 102 | 0x80 | 128 | `rangeArr[0]` upperBound |
| 103 | 0x0 | | |
| 104 | 0x0 | 256 | `rangeArr[1]` lowerBound |
| 105 | 0x1 | | |
| 106 | 0x0 | 512 | `rangeArr[1]` upperBound |
| 107 | 0x2 | | |
| 108 | 0x0 | 1024 | `rangeArr[2]` lowerBound |
| 109 | 0x4 | | |
| 110 | 0x0 | 4096 | `rangeArr[2]` upperBound |
| 111 | 0x10 | | |

```swift
// Retrieve the range array by index
let result: [Range<Int>] = box.getRangeArray(index: 0, rangeWidth: .bit16)

// Output: [Range(1..<128), Range(256..<512), Range(1024..<4096)]
print(result)
```

## Installation  

To integrate `BinaryStore` into your Swift project, add the following to your `Package.swift` file:  

```swift
dependencies: [
    .package(url: "https://github.com/wuyu2015/BinaryStoreSwift.git", from: "0.0.1")
]
```

### Or Install via Xcode  

1. Open your Xcode project.  
2. Go to **File** -> **Swift Packages** -> **Add Package Dependency**.  
3. Enter the GitHub repository URL: `https://github.com/wuyu2015/BinaryStoreSwift.git`.  
4. Choose the desired version (e.g., `0.0.1`) and complete the installation.  

You can now use `BinaryStore` in your project.

## License  

This project is licensed under the MIT License.

---

# BinaryStore  

`BinaryStore` 是一个 Swift Package，旨在创建自定义二进制数据结构。它为开发者提供了一个灵活的工具包，用于构建和操作二进制文件格式。`BinaryStore` 的设计目标是尽量减少存储空间。

如果你有研究别人的二进制数据文件，可能会注意到数据之间的空隙被填充了大量 0 值冗余数据位，这通常是由固定宽度整形 （FixedWidthInteger）引起的，导致了显著的空间浪费。为了解决这个问题，除了标准的 8 位、16 位、32 位、64 位整型之外，`BinaryStore` 还支持 24 位、40 位、48 位和 56 位的非主流整型。如果你善用它们，可以减少不必要的 0 值，从而优化数据大小。

对于那些对网络数据大小有严格要求的应用，考虑使用自定义的二进制数据替代 JSON 字符串。除压缩算法外，消除冗余数据位也是一个重要的优化策略。将多个值打包进一个整数可以进一步优化存储（在语言层面，位操作符已经提供了必要的工具来实现这一点），在你得到那样的一个整数后，你可能需要将其存储到文件或通过网络传输，也许这时候你需要一个24 位 或 40 位的整型。

此外，`BinaryStore` 保持 O(1) 的读写效率，性能接近原生数组操作。

以下代码示例演示了将 `Int`、`Int` 数组、`String`、`String` 数组、`Range` 和 `Range` 数组存储为二进制的简单案例。在实际的应用场景中，这些数据类型通常是混合存储的，通常对应于 Swift 的一个 `Struct`。这样的代码需要你自己来完成。在源代码中，虽然有支持 plist 存储的函数，但使用 plist 来支持二进制存储并不是 `BinaryStore` 的最终目标，因此在演示代码中没有提供。浮点数的支持目前尚未实现，但可能会在未来版本中添加。

## 快速开始  

### 初始化 `BinaryStore.box`  

```swift
import BinaryStore

// `buf` 可以是任意的 UInt8 集合，
// 例如：Array<UInt8>, Data, UnsafeMutablePointer<UInt8>, UnsafeBufferPointer<UInt8>…
var buf: [UInt8] = []
let box = BinaryStore.Box(bytes: &buf)
```

### 整型

```swift
// 用 1 字节存储
box.setInt(123, offset: 0)

// 用 2 字节存储
box.setInt(65535, offset: 1, intWidth: .bit16)

// 用 3 字节存储 65536
box.setInt(65536, offset: 3, intWidth: .bit24)

// 用 5 字节存储中国大陆手机号码
box.setInt(13888888888, offset: 6, intWidth: .bit40)

// 总用了 11 字节
print(box.count) // 输出：11
```

现在 `buf` 的字节如下（Little Endian）：

| 地址 | 字节值 | 说明 |
|-|-|-|
| 0 | 0x7B | 123 |
| 1 | 0xFF | 65535 |
| 2 | 0xFF | |
| 3 | 0x00 | 65536 |
| 4 | 0x00 | |
| 5 | 0x01 | |
| 6 | 0x33 | 13888888888 |
| 7 | 0xBD | |
| 8 | 0x7A | |
| 9 | 0x03 | |
| 10 | 0x08 | |

```swift
// 读取整数
let n1: UInt8 = box.getInt(offset: 0)
let n2: UInt16 = box.getInt(offset: 1, intWidth: .bit16)
let n3 UInt32 = box.getInt(offset: 3, intWidth: .bit24)
let n4: Int = box.getInt(offset: 6, intWidth: .bit40)
```

### 整型数组  

```swift
// 准备数据
let arr: [Int8] = [1, 2, 3, 4, -1, -2, -3, -4]  

// 储存数组
box.setIntArray(arr, index: 10, offset: 1024 * 64, arrayWidth: .bit8, intWidth: .bit8)
```

> 参数说明：
> 1. `index`: 索引地址
> 2. `offset`: 数据地址
> 3. `arrayWidth`: 数组长度宽度
> 4. `intWidth`: 整型宽度

现在 `buf` 的字节如下（Little Endian）：

| 地址 | 字节值 | 字节意义 | 说明 |
|-|-|-|-|
| ... | 0x0 |  | 未使用 |
| 10 | 0x00 | 65536 | 数据地址（4 字节储存） |
| 11 | 0x00 | | |
| 12 | 0x01 | | |
| 13 | 0x00 | | |
| 14 | 0x8 | 8 | 数据字节数（4 字节储存） |
| 15 | 0x00 | | |
| 16 | 0x00 | | |
| 17 | 0x00 | | |
| ... | 0x0 |  | 未使用 |
| 65536 | 0x01 | 1 | |
| 65537 | 0x02 | 2 | |
| 65538 | 0x03 | 3 | |
| 65539 | 0x04 | 4 | |
| 65540 | 0xFF | -1 或 255 | |
| 65541 | 0xFE | -2 或 254 | |
| 65542 | 0xFD | -3 或 253 | |
| 65543 | 0xFC | -4 或 252 | |

```swift
// 现在，我们使用索引值读取数组
let result1: [Int] = box.getIntArray(index: 10, arrayWidth: .bit8, intWidth: .bit8)

// 输出：[1, 2, 3, 4, -1, -2, -3, -4]  
print(result1)

// 用 [UInt8] 读取，负数会转为对应的无符号值
let result2: [UInt8] = box.getIntArray(index: 10, arrayWidth: .bit8, intWidth: .bit8)

// 输出：[1, 2, 3, 4, 255, 254, 253, 252]
print(result2)

// 用 [UInt32] 读取，注意它的效果和 [UInt8] 相同
let result3: [UInt32] = box.getIntArray(index: 10, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result3)
```

> 注意：确保宽度匹配至关重要，灵活使用不同宽度类型会让非法解析你二进制文件的人头疼。

### 字符串  

```swift
let s = "Hello world!"

// 储存字符串
box.setString(s, index: 0, offset: 100)
```

> 参数说明：
> 1. `index`: 索引地址
> 2. `offset`: 数据地址

现在 `buf` 的字节如下（Little Endian）：

| 地址 | 字节值 | 字节意义 | 说明 |
|-|-|-|-|
| 0 | 0x64 | 100 |数据地址（4 字节储存）|
| 1 | 0x0 | | |
| 2 | 0x0 | | |
| 3 | 0x0 |  | |
| ... | 0x0 |  |未使用|
| 100 | 0xC | 12 |字符串字节数（1 字节储存）|
| 101 | 0x48 | "H" | |
| 102 | 0x65 | "e" | |
| 103 | 0x6C | "l" | |
| 104 | 0x6C | "l" | |
| 105 | 0x6F | "o" | |
| 106 | 0x20 | " " | 空格 |
| 107 | 0x77 | "w" | |
| 108 | 0x6F | "o" | |
| 109 | 0x72 | "r" | |
| 110 | 0x6C | "l" | |
| 111 | 0x64 | "d" | |
| 112 | 0x21 | "!" | |

```swift
// 通过索引（0）取出字符串
let s1 = box.getString(index: 0))

// 输出：Hello world!
print(s1)

// 或直接通过地址（100）取出字符串
let s2 = box.getString(offset: 100)

// 输出：Hello world!
print(s2)
```

### 字符串数组  

```swift
let arr = ["Hello world!", "a", "ab", "abc"]

// 储存字符串数组
box.setStringArray(arr, index: 0, offset: 100, offsetWidth: .bit16, byteWidth: .bit16, arrayWidth: .bit8, withArrayIndex: true)
```

> 参数说明：
> 1. `index`: 索引地址
> 2. `offset`: 数据地址
> 3. `offsetWidth`: 数据地址宽度，默认 .bit32
> 4. `byteWidth`: 数据字节数宽度，默认 .bit32
> 5. `arrayWidth`: 数组长度宽度，无默认值
> 5. `withArrayIndex`: 是否生成数据地址的索引，默认 false，不生成。

现在 `buf` 的字节如下（Little Endian）：

| 地址 | 字节值 | 字节意义 | 说明 |
|-|-|-|-|
| 0 | 0x64 | 100 | 数据地址（2 字节储存） |
| 1 | 0x0 | | |
| 2 | 0x19 | 25 | 数据字节数（2 字节储存） |
| 3 | 0x0 | | |
| 4 | 0x7D | 125 | 索引地址（2 字节储存） |
| 6 | 0x0 | | |
| 7 | 0x6 | 6 | 索引字节数（2 字节储存） |
| 8 | 0x0 | | |
| ... | 0x0 |  | 未使用 |
| 100 | 0x4 | 4 | 数组长度（1 字节储存） |
| 101 | 0xC | 12 | "Hello world!" 长度（1 字节储存） |
| 102 | 0x48 | "H" | |
| 103 | 0x65 | "e" | |
| 104 | 0x6C | "l" | |
| 105 | 0x6C | "l" | |
| 106 | 0x6F | "o" | |
| 107 | 0x20 | " " | |
| 108 | 0x77 | "w" | |
| 109 | 0x6F | "o" | |
| 110 | 0x72 | "r" | |
| 111 | 0x6C | "l" | |
| 112 | 0x64 | "d" | |
| 113 | 0x21 | "!" | |
| 114 | 0x1 | 1 | "a" 长度（1 字节储存） |
| 115 | 0x61 | "a" | |
| 116 | 0x2 | 2 | "ab" 长度（1 字节储存） |
| 117 | 0x61 | "a" | |
| 118 | 0x62 | "b" | |
| 119 | 0x3 | 3 | "abc" 长度（1 字节储存） |
| 120 | 0x61 | "a" | |
| 121 | 0x62 | "b" | |
| 122 | 0x63 | "c" | |
| 123 | 0x65 | 101 | 索引开始："Hello world!"地址（2 字节储存） |
| 124 | 0x0 | | |
| 125 | 0x72 | 114 | "a" 地址（ 2 字节储存） |
| 126 | 0x0 | | |
| 127 | 0x74 | 116 | "ab" 地址（ 2 字节储存） |
| 128 | 0x0 | | |
| 129 | 0x79 | 119 | "abc" 地址（2 字节储存） |
| 130 | 0x0 | | |


```swift
// 通过索引（0）取出字符串数组
let result1 = box.getStringArray(index: 0, offsetWidth: .bit16, byteWidth: .bit16, arrayWidth: .bit8)

// 输出：["Hello world!", "a", "ab", "abc"]
print(result1)

// 或直接通过地址（100）取出字符串数组
let result2 = box.getStringArray(offset: 100, arrayWidth: .bit8)

// 输出：["Hello world!", "a", "ab", "abc"]
print(result2)
```

### Range  

```swift
let range = 0..<128

// 存储 range
box.setRange(range, offset: 0, rangeWidth: .bit16)
```

现在 `buf` 的字节如下（Little Endian）：

| 地址 | 字节值 | 字节意义 | 说明 |
|-|-|-|-|
| 0 | 0x0 | 0 | range 的 lowerBound |
| 1 | 0x0 | | |
| 2 | 0x80 | 128 | range 的 upperBound |
| 3 | 0x0 | | |

```swift
// 直接通过偏移值（0）取出 range
let result: Range<Int> = box.getRange(offset: 0, rangeWidth: .bit16)

// 输出: 0..<128
print(result)
```

### Range 数组  

```swift
let rangeArr: [Range<Int>] = [
    1..<128,
    256..<512,
    1024..<4096
]

// 存储 range 数组
box.setRangeArray(rangeArr, index: 0, offset: 100, rangeWidth: .bit16)
```

| 地址 | 字节值 | 字节意义 |说明|
|-|-|-|-|
| 0 | 0x64 | 100 |数据地址（4 字节储存）|
| 1 | 0x0 | | |
| 2 | 0x0 | | |
| 3 | 0x0 |  | |
| 4 | 0xD | 12 |数据字节数（4 字节储存）|
| 5 | 0x0 | | |
| 6 | 0x0 | | |
| 7 | 0x0 |  | |
| ... | 0x0 |  |未使用|
| 100 | 0x0 | 0 |rangeArr[0] 的 lowerBound|
| 101 | 0x0 |  | |
| 102 | 0x80 | 128 |rangeArr[0] 的 upperBound|
| 103 | 0x0 |  | |
| 104 | 0x0 | 256 |rangeArr[1] 的 lowerBound|
| 105 | 0x1 |  | |
| 106 | 0x0 | 512 |rangeArr[1] 的 upperBound|
| 107 | 0x2 |  | |
| 108 | 0x0 | 1024 |rangeArr[2] 的 lowerBound|
| 109 | 0x4 |  | |
| 110 | 0x0 | 4096 |rangeArr[2] 的 upperBound|
| 111 | 0x10 |  | |


```swift
// 通过索引取出 range 数组
let result: [Range<Int>] = box.getRangeArray(index: 0, rangeWidth: .bit16)

// 输出：[Range(1..<128), Range(256..<512), Range(1024..<4096)]
print(result)
```

## 安装  

要将 `BinaryStore` 集成到你的 Swift 项目中，请在 `Package.swift` 文件中添加以下内容：  

```swift
dependencies: [
    .package(url: "https://github.com/wuyu2015/BinaryStoreSwift.git", from: "0.0.1")
]
```

### 或使用 Xcode 安装  

1. 打开你的 Xcode 项目。  
2. 依次选择 **File** -> **Swift Packages** -> **Add Package Dependency**。  
3. 在弹出的窗口中输入 GitHub 仓库地址：`https://github.com/wuyu2015/BinaryStoreSwift.git`。  
4. 选择所需的版本（例如 `0.0.1`）并完成安装。  

这样，你就可以在项目中使用 `BinaryStore` 了。

## 许可证  

本项目采用 MIT 许可证。
