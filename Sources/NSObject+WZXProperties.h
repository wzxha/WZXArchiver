//
//  NSObject+WZXProperties.h
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WZXProperties)

/**
 *  获取一个类所有的成员变量名
 *
 *  @return @[...]
 */
- (NSArray <NSString *> *)wzx_allPropertyNames;

@end
