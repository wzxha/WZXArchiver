//
//  WZXArchiver.h
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+WZXArchiver.h"
@interface WZXArchiver : NSObject

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
 *  清除一个类别和归档对象的名字的特点归档
 *
 *  @param className 类别的名字
 *  @param name      归档对象的名字
 */
+ (void)clear:(NSString *)className andName:(NSString *)name;

@end
