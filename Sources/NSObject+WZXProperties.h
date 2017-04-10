//
//  NSObject+WZXProperties.h
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WZXProperties)

typedef NS_ENUM(NSInteger, WZXPropertyType) {
    WZXPropertyTypeNSClass,
    WZXPropertyTypeInteger,
    WZXPropertyTypeUInteger,
    WZXPropertyTypeDouble,
    WZXPropertyTypeBool,
    WZXPropertyTypeInt,
    WZXPropertyTypeFloat,
    WZXPropertyTypeShort,
    WZXPropertyTypeNull
};

/**
 *  获取一个类所有的成员变量及类型
 *
 *  @return @[@{@"name":@"xxx", @"type":@"xxxx"}...]
 */
- (NSArray *)wzx_allPropertys;

@end
