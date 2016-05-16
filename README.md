# WZXArchiver
自动化归档及解归档<br>
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/Wzxhaha/WZXArchiver/blob/master/LICENSE)

# How to use
1.任意创建一个`NSObject`类.如：PersonModel.

2.(1)如果你只需要归档和解归档功能：导入头文件`#import "NSObject+WZXArchiver.h"`<br>
    (2)如果你还需要清除归档缓存功能: 导入头文件`#import "WZXArchiver.h"`

3.给Model赋值.例如:
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
    
    //其他对象(暂未解决--2016.05.16)
    ManModel * manModel = [[ManModel alloc]init];
    manModel.name = @"wzx";
    manModel.age = 23;
    
    model.manModel = manModel;
```

4.归档，Name为你为这个归档设置的唯一名.
```objc
BOOL isHave = [model wzx_archiveToName:@"person1"];
    NSAssert(isHave = YES, @"归档失败");
```

5.解归档,Name为你刚才设置的唯一名.
```objc
PersonModel * model2 = [PersonModel wzx_unArchiveToName:@"person1"];
```
