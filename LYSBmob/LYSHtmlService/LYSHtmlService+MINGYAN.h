//
//  LYSHtmlService+MINGYAN.h
//  LYSBmob
//
//  Created by 刘永生 on 16/9/17.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSHtmlService.h"

@interface LYSHtmlService (MINGYAN)

+ (void) htmlService_MINGYAN_GetUrlString:(NSString *)aUrlString
                            responseBlock:(void (^)(NSURLSessionDataTask *task, NSMutableArray <NSDictionary *>* responseArray, NSError *error))responseBlock;

@end
