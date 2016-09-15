//
//  LYSHtmlService.m
//  LYSBmob
//
//  Created by 刘永生 on 16/9/15.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSHtmlService.h"

@implementation LYSHtmlService

+ (LYSHtmlService *)sharedManager
{
    static LYSHtmlService *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[LYSHtmlService alloc]init];
        }
    });
    return sharedInstance;
}


@end
