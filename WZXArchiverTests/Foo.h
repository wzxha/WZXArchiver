//
//  ManModel.h
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bar;

@interface Foo: NSObject

@property (nonatomic, copy) NSString *str;
@property (nonatomic, strong) NSMutableString *muStr;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) NSMutableArray *muArr;
@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, strong) NSMutableDictionary *muDic;
@property (nonatomic, copy) NSData *data;
@property (nonatomic, strong) NSMutableData *muData;
@property (nonatomic, copy) NSSet *set;
@property (nonatomic, strong) NSMutableSet *muSet;

@property (nonatomic, assign) NSInteger w_integer;
@property (nonatomic, assign) NSUInteger w_uinteger;
@property (nonatomic, assign) CGFloat w_cgfloat;
@property (nonatomic, assign) BOOL w_bool;
@property (nonatomic, assign) int w_int;
@property (nonatomic, assign) double w_doule;
@property (nonatomic, assign) float w_float;

@property (nonatomic, strong) Bar *bar;

@end

@interface Bar: NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
