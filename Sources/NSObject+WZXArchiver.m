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
    NSString *path = [[self class] _pathWithName: name];
    
    [[self class] _createDicWithPath: path];
    
    return [NSKeyedArchiver archiveRootObject: self toFile: path];
}

+ (id)wzx_unArchiveToName:(NSString *)name {
    return [NSKeyedUnarchiver unarchiveObjectWithFile: [[self class] _pathWithName: name]];
}

+ (void)_createDicWithPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager new];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: path]) {
        [fileManager createDirectoryAtPath: [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"WZXArchiver"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (NSString *)_pathWithName:(NSString *)name{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent: [NSString stringWithFormat:@"WZXArchiver/%@_%@.archiver", NSStringFromClass(self.class), name]];
    return path;
}


#pragma mark -- NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *propertyNames = [self wzx_allPropertyNames];
    for (NSString *propertyName in propertyNames) {
        [aCoder encodeObject: [self valueForKey:propertyName] forKey: propertyName];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSArray *propertyNames = [self wzx_allPropertyNames];
    for (NSString *propertyName in propertyNames) {
        [self setValue: [aDecoder decodeObjectForKey:propertyName] forKey: propertyName];
    }
    return self;
}

#pragma clang diagnostic pop

@end
