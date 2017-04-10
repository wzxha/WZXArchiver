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

- (NSArray *)wzx_allPropertys {
    NSMutableArray *propertyArr = [NSMutableArray array];
    
    unsigned int outCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] ;
        
        NSString *propertyType = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] ;
        
        [propertyArr addObject:@{
                                   @"name": propertyName,
                                   @"type": [self stringWithType:propertyType]
                                   }];
    }
    
    free(properties);
    
    return propertyArr;
}

- (nullable NSString *)stringWithType:(NSString *)attributes {
    if (![attributes hasPrefix:@"T"]) {
        return nil;
    }
    
    if ([attributes hasPrefix:@"T@"]) {
        if ([attributes hasPrefix:@"T@\"NS"]) {
            return [attributes componentsSeparatedByString:@"\""][1];
        } else {
            //                Class class = [NSString stringWithFormat:@"__Model__:%@",[attributes componentsSeparatedByString:@"\""][1]];
            
        }
    }
    
    if ([attributes hasPrefix:@"Tq"]) {
        return @"NSInteger";
    } else if ([attributes hasPrefix:@"TQ"]) {
        return @"NSUInteger";
    } else if ([attributes hasPrefix:@"Td"]) {
        return @"double";
    } else if ([attributes hasPrefix:@"TB"]) {
        return @"BOOL";
    } else if ([attributes hasPrefix:@"Ti"]) {
        return @"int";
    } else if ([attributes hasPrefix:@"Tf"]) {
        return @"float";
    } else if ([attributes hasPrefix:@"Ts"]) {
        return @"short";
    }
    
    return nil;
}

@end
