//
//  WZXArchiverTests.m
//  WZXArchiverTests
//
//  Created by wzxjiang on 2017/4/10.
//  Copyright © 2017年 Null. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WZXArchiver.h"
#import "Foo.h"

@interface WZXArchiverTests : XCTestCase

@end

@implementation WZXArchiverTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    Foo *foo = [Foo new];
    
    foo.str = @"str";
    
    NSMutableString *muStr = [NSMutableString stringWithString:foo.str];
    foo.muStr = muStr;
    
    foo.dic = @{@"key":@"value"};
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:foo.dic];
    foo.muDic = muDic;
    
    foo.arr = @[@"arr1",@"arr2"];
    
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:foo.arr];
    foo.muArr = muArr;
    
    foo.data = [foo.str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *muData = [NSMutableData dataWithData:foo.data];
    foo.muData = muData;
    
    foo.set = [NSSet setWithObjects:@"1",@"2",@"3",nil];
    
    NSMutableSet *muSet = [NSMutableSet setWithSet:foo.set];
    foo.muSet = muSet;
    
    foo.w_float = 1.1;
    foo.w_doule = 2.2;
    foo.w_cgfloat = 3.3;
    foo.w_int = 4;
    foo.w_integer = 5;
    foo.w_uinteger = 6;
    foo.w_bool = YES;
    
    Bar *bar = [Bar new];
    bar.name = @"wzx";
    bar.age = 23;
    
//    bar.manModel = manModel;
    
    BOOL isHave = [foo wzx_archiveToName:@"foo"];
    NSAssert(isHave = YES, @"归档失败");
    
    Foo *foo2 = [Foo wzx_unArchiveToName:@"foo"];
    
    XCTAssertTrue([foo2.str isEqualToString: [muStr copy]]);
    XCTAssertTrue([foo2.muStr isEqual: muStr]);

    XCTAssertTrue([foo2.dic isEqual: [muDic copy]]);
    XCTAssertTrue([foo2.muDic isEqual:muDic]);
    
    XCTAssertTrue([foo2.arr isEqual: [muArr copy]]);
    XCTAssertTrue([foo2.muArr isEqual: muArr]);
                   
    XCTAssertTrue([foo2.data isEqual: [muData copy]]);
    XCTAssertTrue([foo2.muData isEqual: muData]);
    
    XCTAssertTrue([foo2.set isEqual: [muSet copy]]);
    XCTAssertTrue([foo2.muSet isEqual: muSet]);
    
    XCTAssertTrue([foo2.arr isEqual: [muArr copy]]);
    XCTAssertTrue([foo2.muArr isEqual: muArr]);

    XCTAssertTrue(foo2.w_float == foo.w_float);
    XCTAssertTrue(foo2.w_doule == foo.w_doule);
    XCTAssertTrue(foo2.w_cgfloat == foo.w_cgfloat);
    XCTAssertTrue(foo2.w_int == 4);
    XCTAssertTrue(foo2.w_integer == 5);
    XCTAssertTrue(foo2.w_uinteger == 6);
    XCTAssertTrue(foo2.w_bool == YES);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
