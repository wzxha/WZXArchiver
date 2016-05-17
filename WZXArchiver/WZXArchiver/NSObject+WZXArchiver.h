//
//  NSObject+WZXArchiver.h
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WZXArchiver)

/**
 *  通过自定的名字归档
 *
 *  @param name 名字
 *
 *  @return 是否成功
 */
- (BOOL)wzx_archiveToName:(NSString *)name;

/**
 *  通过之前归档的名字解归档
 *
 *  @param name 名字
 *
 *  @return 解归档的对象
 */
+ (id)wzx_unArchiveToName:(NSString *)name;

/**
 *  获取对象中包含的对象的归档
 *
 *  @param name  子对象地址,可用WZXArchiver_SonPath宏
 *
 *  @return 对象中包含的对象
 */
+ (id)wzx_unArchiveSonEntityToName:(NSString *)name;
@end



