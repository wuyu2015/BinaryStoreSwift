# BinaryStore  

`BinaryStore` is a Swift Package designed for creating custom binary data files, focusing on storage efficiency. It allows developers to flexibly construct and manipulate binary file formats. In addition to the standard 8-bit, 16-bit, 32-bit, and 64-bit integer types, BinaryStore also supports non-standard integer lengths such as 24-bit, 40-bit, 48-bit, and 56-bit for more efficient storage.

## Getting Started  

### Initializing `BinaryStore.box`  

```swift
import BinaryStore

// `buf` can be any collection of UInt8,
// for example: Array<UInt8>, Data, UnsafeMutablePointer<UInt8>, or UnsafeBufferPointer<UInt8> …
var buf: [UInt8] = []
let box = BinaryStore.Box(bytes: &buf)
```

### Integer Storage  

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

| Index   | Byte Value | Description              |
|---------|--------------|------------------------|
| 0         | 0x7B           | 123                          |
| 1         | 0xFF           | 65535                      |
| 2         | 0xFF           |                                 |
| 3         | 0x00           | 65536                      |
| 4         | 0x00           |                                 |
| 5         | 0x01           |                                 |
| 6         | 0x33           | 13888888888          |
| 7         | 0xBD          |                                 |
| 8         | 0x7A           |                                 |
| 9         | 0x03           |                                 |
| 10       | 0x08           |                                 |

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

// Write the array at an offset of 64K, and store this offset at position 10
box.setIntArray(arr, index: 10, offset: 1024 * 64, arrayWidth: .bit8, intWidth: .bit8)

// Total bytes: 1024 * 64 + arr.count bytes, 
// i.e., 65536 + 8 = 65544
print(box.count) // Output: 65544
```

The bytes of `buf` are now as follows (Little Endian):  

| Index      | Byte Value | Description      |
|-----------|-------------|-------------------|
| 0             | 0x0           | Unused             |
| ...            | 0x0           | Unused             |
| 10           | 0x00         | Offset: 65536    |
| 11           | 0x00         |                          |
| 12           | 0x01         |                          |
| 13           | 0x00         | (Offset end)      |
| 14           | 0x08         | Array count: 8  |
| ...            | 0x0           | Unused            |
| 65536     | 0x01         | 1                       |
| 65537     | 0x02         | 2                       |
| 65538     | 0x03         | 3                       |
| 65539     | 0x04         | 4                       |
| 65540     | 0xFF         | -1 or 255          |
| 65541     | 0xFE         | -2 or 254          |
| 65542     | 0xFD         | -3 or 253         |
| 65543     | 0xFC         | -4 or 252         |

```swift
// Now, we read the array using the index value
let result1: [Int] = box.getIntArray(index: 10, offsetWidth: .bit32, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, -1, -2, -3, -4]  
print(result1)

// Read with [UInt8], negative numbers will be converted to the corresponding unsigned values
let result2: [UInt8] = box.getIntArray(index: 10, offsetWidth: .bit32, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result2)

// Read with [UInt32], note that it has the same effect as [UInt8] because we used the .bit8 tag
let result3: [UInt]32 = box.getIntArray(index: 10, offsetWidth: .bit32, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result3)
```

> Note: Ensuring the width types match is critical. Using different width types flexibly will make it difficult for others to incorrectly parse your binary files.


### String  

```swift
let s = "Hello world!"

// Write the string at offset 100, storing the index at position 0
box.setString(s, index: 0, offset: 100)
```

Now, the bytes in `buf` are as follows (Little Endian):

| Index  | Byte Value | Description            |
|--------|------------|------------------------|
| 0        | 0x0          | Offset: 65536           |
| 1        | 0x0          |                                  |
| 2        | 0x1          |                                  |
| 3        | 0x0          | (Offset end)              |
| ...       | 0x0          | Unused                     |
| 100    | 0xC         | Byte count: 12          |
| 101    | 0x48        | "H"                           |
| 102    | 0x65        | "e"                            |
| 103    | 0x6C        | "l"                             |
| 104    | 0x6C        | "l"                             |
| 105    | 0x6F        | "o"                            |
| 106    | 0x20        | " " (space)                |
| 107    | 0x77        | "w"                           |
| 108    | 0x6F        | "o"                            |
| 109    | 0x72        | "r"                             |
| 110    | 0x6C        | "l"                             |
| 111    | 0x64        | "d"                            |
| 112    | 0x21        | "!"                             |

```swift
// Retrieve the string using the index
let s1 = box.getString(index: 0)

// Output: Hello world!
print(s1)

// Or retrieve the string directly using offset 100
let s2 = box.getString(offset: 100)

// Output: Hello world!
print(s2)
```

### String Arrays  

```swift
let arr = ["a", "b", "c", "Hello world!"]

// Write the string array at offset 64K, storing the index at position 0
box.setStringArray(arr, index: 0, offset: 64 * 1024, arrayWidth: .bit8, stringWidth: .bit8)

// Retrieve the string array using the index
_ = getStringArray(index: 0, offsetWidth: .bit32, arrayWidth: .bit8, stringWidth: .bit8)

// Or retrieve it directly using the offset at 64K
_ = getString(64 * 1024, arrayWidth: .bit8, countWidth: .bit8)
```

### Ranges  

```swift
let range = 0..<128

// Store the range
box.setRangeArray(range, index: 0, offset: 64 * 1024, itemWidth: .bit8)

// Retrieve the range using the index
_ = setRange(index: 0, offsetWidth: .bit32, itemWidth: .bit8)

// Retrieve the range directly using the offset
_ = getRange(64 * 1024, 100, itemWidth: .bit8)
```

### Range Arrays  

```swift
let arr: [Range<Int>] = [
    0..<128,
    128..<256,
    256..<512,
]

// Store the range array
box.setRangeArray(arr, index: 0, offset: 64 * 1024, offsetWidth: .bit32, countWidth: .bit32, itemWidth: .bit32)

// Retrieve the range array using the index
let result: [Range<Int>] = getRangeArray(index: 0, offsetWidth: .bit32, countWidth: .bit32, itemWidth: .bit32)
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

`BinaryStore` 是一个 Swift Package，为创建自定义二进制数据文件而设计，重点在于节省存储空间。它允许开发者灵活地构建和操作二进制文件格式。除了标准的 8 位、16 位、32 位、64 位整型之外，BinaryStore 还支持 24 位、40 位、48 位和 56 位的非主流整型。  

## 快速开始  

### 初始化 `BinaryStore.box`  

```swift
import BinaryStore

// `buf` 可以是任意的 UInt8 集合，
// 例如：Array<UInt8>, Data, UnsafeMutablePointer<UInt8>, UnsafeBufferPointer<UInt8>…
var buf: [UInt8] = []
let box = BinaryStore.Box(bytes: &buf)
```

### 整型存储  

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

| 索引    | 字节值        | 说明                         |
|--------|---------------|------------------------|
| 0         | 0x7B           | 123                          |
| 1         | 0xFF           | 65535                      |
| 2         | 0xFF           |                                 |
| 3         | 0x00           | 65536                      |
| 4         | 0x00           |                                 |
| 5         | 0x01           |                                 |
| 6         | 0x33           | 13888888888          |
| 7         | 0xBD          |                                 |
| 8         | 0x7A           |                                 |
| 9         | 0x03           |                                 |
| 10       | 0x08           |                                 |

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

// 在 64K 偏移处写入数组，该偏移量则存储在位置 10
box.setIntArray(arr, index: 10, offset: 1024 * 64, arrayWidth: .bit8, intWidth: .bit8)

// 总字节：1024 * 64 + arr.count 字节，
// 即 65536 + 8 = 65544
print(box.count) // 输出：65544
```

现在 `buf` 的字节如下（Little Endian）：

| 索引       | 字节值     | 说明                         |
|-----------|------------|------------------------|
| 0            | 0x0          | 未使用                      |
| ...           | 0x0          | 未使用                      |
| 10          | 0x00        | 偏移量：65536        |
| 11          | 0x00        |                                  |
| 12          | 0x01        |                                  |
| 13          | 0x00        | （偏移量结束）        |
| 14          | 0x8          | 数组元素个数：8      |
| ...           | 0x0          | 未使用                      |
| 65536    | 0x01        | 1                               |
| 65537    | 0x02        | 2                               |
| 65538    | 0x03        | 3                               |
| 65539    | 0x04        | 4                               |
| 65540    | 0xFF        | -1 或 255                  |
| 65541    | 0xFE        | -2 或 254                  |
| 65542    | 0xFD        | -3 或 253                 |
| 65543    | 0xFC        | -4 或 252                 |

```swift
// 现在，我们使用索引值读取数组
let result1: [Int] = box.getIntArray(index: 10, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, -1, -2, -3, -4]  
print(result1)

// 用 [UInt8] 读取，负数会转为对应的无符号值
let result2: [UInt8] = box.getIntArray(index: 10, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result2)

// 用 [UInt32] 读取，注意它的效果和 [UInt8] 相同，因为我们使用了 `.bit8` 标记
let result3: [UInt32] = box.getIntArray(index: 10, arrayWidth: .bit8, intWidth: .bit8)

// Output: [1, 2, 3, 4, 255, 254, 253, 252]
print(result3)
```

> 注意：确保宽度匹配至关重要，灵活使用不同宽度类型会让非法解析你二进制文件的人头疼。

### 字符串  

```swift
let s = "Hello world!"

// 在 100 偏移处写入字符串，索引存储在 0 位置
box.setString(s, index: 0, offset: 100)
```

现在 `buf` 的字节如下（Little Endian）：

| 索引       | 字节值     | 说明                                 |
|-----------|------------|-----------------------------|
| 0            | 0x0          | 偏移量：65536                |
| 1            | 0x0          |                                         |
| 2            | 0x1          |                                         |
| 3            | 0x0          | （偏移量结束）               |
| ...           | 0x0          | 未使用                             |
| 100        | 0xC         | 字节数：12                      |
| 101        | 0x48        | "H"                                  |
| 102        | 0x65        | "e"                                   |
| 103        | 0x6C        | "l"                                    |
| 104        | 0x6C        | "l"                                    |
| 105        | 0x6F        | "o"                                   |
| 106        | 0x20        | " "                                    |
| 107        | 0x77        | "w"                                  |
| 108        | 0x6F        | "o"                                  |
| 109        | 0x72        | "r"                                   |
| 110        | 0x6C        | "l"                                   |
| 111        | 0x64        | "d"                                  |
| 112        | 0x21        | "!"                                   |

```swift
// 通过索引取出字符串
let s1 = box.getString(index: 0))

// 输出：Hello world!
print(s1)

// 或者直接通过偏移值 100 取出字符串
let s2 = box.getString(offset: 100)

// 输出：Hello world!
print(s2)
```

### 字符串数组  

```swift
let arr = ["a", "b", "c", "Hello world!"]

// 在 64K 偏移处写入字符串数组，索引存储在 0 位置
box.setStringArray(arr, index: 0, offset: 64 * 1024, arrayWidth: .bit24)

// 通过索引取出字符串数组
_ = getStringArray(index: 0, offsetWidth: .bit32, arrayWidth: .bit24)

// 或者直接通过偏移值（64K 处）取出字符串数组
_ = getString(64 * 1024, 100, arrayWidth: .bit8)
```

### Range  

```swift
let range = 0..<128

// 存储 range
box.setRangeArray(range, index: 0, offset: 64 * 1024, itemWidth: .bit8)

// 通过索引取出 range
_ = setRange(index: 0, offsetWidth: .bit32, itemWidth: .bit8)

// 直接通过偏移值取出 range
_ = getRange(64 * 1024, 100, itemWidth: .bit8)
```

### Range 数组  

```swift
let arr: [Range<Int>] = [
    0..<128,
    128..<256,
    256..<512,
]

// 存储 range 数组
box.setRangeArray(arr, index: 0, offset: 64 * 1024, offsetWidth: .bit32, countWidth: .bit32, itemWidth: .bit32)

// 通过索引取出 range 数组
let result: [Range<Int>] = getRangeArray(index: 0, offsetWidth: .bit32, countWidth: .bit32, itemWidth: .bit32)
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
