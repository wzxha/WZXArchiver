# WZXArchiver
自动化归档及解档<br>
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/Wzxhaha/WZXArchiver/blob/master/LICENSE)

# 怎么使用WZXArchiver归档和解档
1. 任意创建一个`NSObject`类.如：PersonModel.

2. 
如果你只需要归档和解归档功能：导入头文件`#import "NSObject+WZXArchiver.h"`<br>
如果你还需要清除归档缓存功能: 导入头文件`#import "WZXArchiver.h"`

3. 给Model赋值.例如:
 ```objc
PersonModel * model = [[PersonModel alloc]init];
    //Object数据
    model.str = @"str";
    model.muStr = [NSMutableString stringWithString:@"muStr"];
    model.dic = @{@"key":@"value"};
    model.muDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                  @"key":@"muValue"
                                                                }];
    model.arr = @[@"arr1",@"arr2"];
    model.muArr = [NSMutableArray arrayWithArray:@[@"muarr1",@"muarr2"]];
    model.data = [model.str dataUsingEncoding:NSUTF8StringEncoding];
    model.muData = [NSMutableData dataWithData:model.data];
    model.set = [NSSet setWithObjects:@"1",@"2",@"3",nil];
    model.muSet = [NSMutableSet setWithSet:model.set];
    
    //基本数据
    model.w_float = 1.1;
    model.w_doule = 2.2;
    model.w_cgfloat = 3.3;
    model.w_int = 4;
    model.w_integer = 5;
    model.w_uinteger = 6;
    model.w_bool = YES;
    
    //其他对象
    ManModel * manModel = [[ManModel alloc]init];
    manModel.name = @"wzx";
    manModel.age = 23;
    
    model.manModel = manModel;
 ```

4. 归档, Name为你为这个归档设置的唯一标识符.
 ```objc
BOOL isHave = [model wzx_archiveToName:@"person1"];
    NSAssert(isHave = YES, @"归档失败");
 ```

5. 解档, Name为你刚才设置的唯一标识符.
 ```objc
PersonModel * model2 = [PersonModel wzx_unArchiveToName:@"person1"];
//若你对象中包含另一个对象
model2.manModel = [ManModel wzx_unArchiveSonEntityToName:WZXArchiver_SonPath(@"PersonModel", @"person1", @"ManModel", @"manModel")];
 ```

# 怎么使用WZXArchiver清除归档的缓存
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
