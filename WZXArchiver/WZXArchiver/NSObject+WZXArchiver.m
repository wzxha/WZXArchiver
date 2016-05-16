//
//  NSObject+WZXArchiver.m
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "NSObject+WZXArchiver.h"
#import "NSObject+WZXProperties.h"

@implementation NSObject (WZXArchiver)

- (BOOL)wzx_archiveToName:(NSString *)name {
    
    NSString * path = [[self class] getPath:name];

    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:[[self class] getRootPath] withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        
    }
    BOOL flag = [NSKeyedArchiver archiveRootObject:self toFile:path];
    return flag;
}

+ (id)wzx_unArchiveToName:(NSString *)name {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getPath:name]];
}

+ (NSString *)getPath:(NSString *)name{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"WZXArchiver/WZX_%@_%@.archiver",NSStringFromClass(self.class),name]];
    NSLog(@"%@",path);
    return path;
}

+ (NSString *)getRootPath {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"WZXArchiver"];
    return path;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray * propertyArr = [self wzx_allProperty];
    for (NSDictionary * propertyDic in propertyArr) {
        [self encodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aCoder];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSArray * propertyArr = [self wzx_allProperty];
    for (NSDictionary * propertyDic in propertyArr) {
        if ([self decodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aDecoder]) {
            [self setValue:[self decodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aDecoder] forKey:propertyDic[@"name"]];
        }
    }
    return self;
}
#pragma clang diagnostic pop


- (id)decodeWithType:(NSString *)type Name:(NSString *)name Coder:(NSCoder *)aDecoder {
    if ([self isObject:type]) {
        
        return [aDecoder decodeObjectOfClass:NSClassFromString(type) forKey:name];
    } else if([type isEqualToString:@"int"]||
              [type isEqualToString:@"short"]){
        
        return @([aDecoder decodeIntegerForKey:name]);
    } else if([type isEqualToString:@"BOOL"]){
        
        return @([aDecoder decodeBoolForKey:name]);
    } else if([type isEqualToString:@"float"]){
        
        return @([aDecoder decodeFloatForKey:name]);
    } else if([type isEqualToString:@"double"]){
        
        return @([aDecoder decodeDoubleForKey:name]);
    } else if([type isEqualToString:@"NSInteger"]||
              [type isEqualToString:@"NSUInteger"]){
        
        return @([aDecoder decodeIntegerForKey:name]);
    }
    return nil;
}

- (void)encodeWithType:(NSString *)type Name:(NSString *)name Coder:(NSCoder *)aCoder {
    if ([self isObject:type]) {
        
        [aCoder encodeObject:[self valueForKey:name] forKey:name];
    } else if([type isEqualToString:@"BOOL"]){
        
        [aCoder encodeBool:[[self valueForKey:name] boolValue] forKey:name];
    } else if([type isEqualToString:@"float"]){
        
        [aCoder encodeFloat:[[self valueForKey:name] floatValue] forKey:name];
    } else if([type isEqualToString:@"double"]){
        
        [aCoder encodeFloat:[[self valueForKey:name] doubleValue] forKey:name];
    } else if([type isEqualToString:@"int"]||
              [type isEqualToString:@"short"]){
        
        [aCoder encodeInt:[[self valueForKey:name] intValue] forKey:name];
    } else if([type isEqualToString:@"NSInteger"]||
              [type isEqualToString:@"NSUInteger"]){
        
        [aCoder encodeInteger:[[self valueForKey:name] integerValue] forKey:name];
    }
    
#pragma mark -- 对象里面的对象未处理 --
    if ([type hasPrefix:@"__Model__:"]) {
//        Class modelClass = NSClassFromString([type componentsSeparatedByString:@"__Model__:"][1]);
//        [[self valueForKey:name] wzx_archiveToName:[NSString stringWithFormat:@""]];
//        self.
    }
}

- (BOOL)isObject:(NSString *)type {
    NSArray * objectTypeArr = @[@"NSString",
                                @"NSMutableString",
                                @"NSArray",
                                @"NSMutableArray",
                                @"NSDictionary",
                                @"NSMutableDictionary",
                                @"NSData",
                                @"NSMutableData",
                                @"NSSet",
                                @"NSMutableSet"];
    return [objectTypeArr containsObject:type];
}
@end
