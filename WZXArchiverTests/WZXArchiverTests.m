//
//  WZXArchiverTests.m
//  WZXArchiverTests
//
//  Created by wzxjiang on 2017/4/10.
//  Copyright © 2017年 Null. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ManModel.h"
#import "PersonModel.h"

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
    PersonModel * model = [[PersonModel alloc]init];
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
    
    model.w_float = 1.1;
    model.w_doule = 2.2;
    model.w_cgfloat = 3.3;
    model.w_int = 4;
    model.w_integer = 5;
    model.w_uinteger = 6;
    model.w_bool = YES;
    
    ManModel * manModel = [[ManModel alloc]init];
    manModel.name = @"wzx";
    manModel.age = 23;
    
    model.manModel = manModel;
    
    BOOL isHave = [model wzx_archiveToName:@"person1"];
    NSAssert(isHave = YES, @"归档失败");
    
    PersonModel * model2 = [PersonModel wzx_unArchiveToName:@"person1"];
    model2.manModel = [ManModel wzx_unArchiveSonEntityToName:WZXArchiver_SonPath(@"PersonModel", @"person1", @"ManModel", @"manModel")];
    NSLog(@"%@",model2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
