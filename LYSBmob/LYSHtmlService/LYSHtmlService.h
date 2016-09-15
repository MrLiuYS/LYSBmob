//
//  LYSHtmlService.h
//  LYSBmob
//
//  Created by 刘永生 on 16/9/15.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GLYSHtml [LYSHtmlService sharedManager]

@interface LYSHtmlService : NSObject

+ (LYSHtmlService *)sharedManager;

@end
