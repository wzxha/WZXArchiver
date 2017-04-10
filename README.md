# WZXArchiver
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/Wzxhaha/WZXArchiver/blob/master/LICENSE)<br>
更加方便的归解档

## Usage
`@import WZXArchiver;`

#### 归档
 ```objc
//  name为这个归档唯一标识符.
BOOL isHave = [foo wzx_archiveToName:@"foo"];
NSAssert(isHave = YES, @"归档失败");
 ```

#### 解档

 ```objc
Foo *foo = [Foo wzx_unArchiveToName:@"foo"];
 ```

#### 清除
```objc
/**
 *  清除所有归档
 */
+ (void)clearAll;

/**
 *  清除一个类别的归档
 *
 *  @param className 类别的名字
 */
+ (void)clear:(NSString *)className;

/**
 *  清除一个(className = 类别)&&(name = 归档对象的名字)的归档
 *
 *  @param className 类别的名字
 *  @param name      归档对象的名字
 */
+ (void)clear:(NSString *)className andName:(NSString *)name;
```

## License 

WZXArchiver is released under the MIT license. See LICENSE for details.
