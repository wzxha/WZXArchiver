//
//  NSObject+WZXArchiver.m
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "NSObject+WZXArchiver.h"
#import "NSObject+WZXProperties.h"
#import <objc/runtime.h>

@interface NSObject ()
@property(nonatomic, copy)NSString * WZX_Archiver_Name;
@end
@implementation NSObject (WZXArchiver)
static NSString * WZX_Archiver_Name_Key = @"WZX_Archiver_Name_Key";
- (void)setWZX_Archiver_Name:(NSString *)WZX_Archiver_Name {
    
    objc_setAssociatedObject(self, &WZX_Archiver_Name_Key, WZX_Archiver_Name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)WZX_Archiver_Name {
    NSString * str = objc_getAssociatedObject(self, &WZX_Archiver_Name_Key);
    return str;
}

- (BOOL)wzx_archiveToName:(NSString *)name {
    return [self wzx_archiveToName:name andIsSon:NO];
}

- (BOOL)wzx_archiveToName:(NSString *)name andIsSon:(BOOL)isSon {
    if (isSon == NO) {
        //不是对象中的子对象
        self.WZX_Archiver_Name = name;
        NSString * path = [[self class] getPath:name];
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"WZXArchiver"] withIntermediateDirectories:YES attributes:nil error:nil];
        } else {
            //已有文件夹
        }
        return [NSKeyedArchiver archiveRootObject:self toFile:path];
        
    } else {
        return [NSKeyedArchiver archiveRootObject:self toFile:[[self class]getSonPath:name]];
    }
    
    
}

+ (id)wzx_unArchiveToName:(NSString *)name {
    return [self wzx_unArchiveToName:name isSon:NO];
}


+ (id)wzx_unArchiveSonEntityToName:(NSString *)name {
    return [self wzx_unArchiveToName:name isSon:YES];
}

+ (id)wzx_unArchiveToName:(NSString *)name isSon:(BOOL)isSon {
    self.WZX_Archiver_Name = name;
    if (isSon == NO) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getPath:name]];
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class]getSonPath:name]];
    }
}

+ (NSString *)getSonPath:(NSString *)name {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"WZXArchiver/WZX_%@.archiver",name]];
    NSLog(@"%@",path);
    return path;
}

+ (NSString *)getPath:(NSString *)name{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"WZXArchiver/WZX_%@_%@.archiver",NSStringFromClass(self.class),name]];
    NSLog(@"%@",path);
    return path;
}


#pragma mark -- NSCoding --

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
    
    if ([type hasPrefix:@"__Model__:"]) {
//        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
//        ;
//        NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"WZXArchiver/WZX_%@_%@_%@.archiver",NSStringFromClass(self.class),self.WZX_Archiver_Name,className]];
//        
//        [self setValue:[NSClassFromString(className) wzx_unArchiveToName:path isSon:YES]forKey:name];
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
    
    if ([type hasPrefix:@"__Model__:"]) {
        
        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
        NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass(self.class),self.WZX_Archiver_Name,className,name];
        
        [[self valueForKey:name] wzx_archiveToName:path andIsSon:YES];
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
