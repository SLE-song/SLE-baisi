//
//  NSString+SLEExtension.m
//  百思不得姐
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 SLE-review. All rights reserved.
//

#import "NSString+SLEExtension.h"

@implementation NSString (SLEExtension)


- (unsigned long long)sle_fileSize
{
    // 初始化总大小
    unsigned long long size = 0;

    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 是否为文件夹
    BOOL isDirectory = NO;

    // 判断是否存在
    BOOL exit = [manager fileExistsAtPath:self isDirectory:&isDirectory];
    
    // 不存在，直接返回0
    if (!exit) return size;

    /** 是文件夹 */
    if (isDirectory) {
        
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        
        for (NSString *subpath in enumerator) {
            
            // 全路径
            NSString *fullPath = [self stringByAppendingPathComponent:subpath];
            
            // 路径大小
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
            
        }
        
        
    }else{/** 如果是文件，不是文件夹 */
    
        size += [manager attributesOfItemAtPath:self error:nil].fileSize;
    
    }
    

    return size;

}









@end
