//
//  LYSHtmlService+JZW.h
//  LYSBmob
//
//  Created by 刘永生 on 16/9/16.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSHtmlService.h"

@interface LYSHtmlService (JZW)

+ (void) htmlService_JZW_GetUrlString:(NSString *)aUrlString
                        responseBlock:(void (^)(NSURLSessionDataTask *task, NSMutableArray <NSDictionary *>* responseArray, NSError *error))responseBlock;

@end
