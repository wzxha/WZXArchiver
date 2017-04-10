//
//  WZXArchiver.m
//  WZXArchiver
//
//  Created by WzxJiang on 16/5/16.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "WZXArchiverManager.h"

@implementation WZXArchiverManager

+ (void)clearAll {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSFileManager *fileManager = [NSFileManager new];
                                  
    [fileManager changeCurrentDirectoryPath:documentPath];
                                  
    NSError *error = nil;
                                  
    [fileManager removeItemAtPath:@"WZXArchiver" error:&error];
                                  
    NSAssert(error == nil, @"删除出错");
}

+ (void)clear:(NSString *)className {
    NSFileManager *fileManager = [NSFileManager new];
    
    [fileManager changeCurrentDirectoryPath: [[self class] archiverPath]];
    
    NSError *error = nil;
    
    NSArray *fileLists = [fileManager contentsOfDirectoryAtPath:fileManager.currentDirectoryPath error:&error];
    
    NSAssert(error == nil, @"查询出错");
    
    for (NSString *fileName in fileLists) {
        if ([fileName hasPrefix: className]) {
            NSError *removeError = nil;
            [fileManager removeItemAtPath: fileName error: &removeError];
            NSAssert(removeError == nil, @"删除出错");
        }
    }
}

+ (void)clear:(NSString *)className andName:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager new];
    
    [fileManager changeCurrentDirectoryPath:[[self class] archiverPath]];
    
    NSError *error = nil;
    
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@_%@.archiver", className, name] error: &error];
    
    NSAssert(error == nil, @"删除出错");
}



+ (NSString *)archiverPath {
    return
    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"WZXArchiver"];
}

@end
