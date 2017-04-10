//
//  NSObject+WZXProperties.m
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "NSObject+WZXProperties.h"
#import <objc/runtime.h>
@implementation NSObject (WZXProperties)

- (NSArray <NSString *> *)wzx_allPropertyNames {
    NSMutableArray *propertyNames = [NSMutableArray array];
    
    unsigned int outCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName =
        [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [propertyNames addObject: propertyName];
    }
    
    free(properties);
    
    return propertyNames;
}


@end
