//
//  NSString+LYSPath.m
//  LYSBmob
//
//  Created by 刘永生 on 16/8/2.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "NSString+LYSPath.h"

@implementation NSString (LYSPath)

+ (NSString *)lys_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSString *)lys_documentsPath
{
    return [self lys_pathForDirectory:NSDocumentDirectory];
}


@end
