//
//  LYSHtmlService.m
//  LYSBmob
//
//  Created by 刘永生 on 16/9/15.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSHtmlService.h"

@interface LYSHtmlService ()

@property (nonatomic, strong) AFHTTPSessionManager *htmlService;

@end

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

- (void)setHtmlUrlString:(NSString *)htmlUrlString {
    _htmlUrlString = htmlUrlString;
    
    _htmlService = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:htmlUrlString]];
    _htmlService.responseSerializer = [AFHTTPResponseSerializer serializer];
    _htmlService.operationQueue.maxConcurrentOperationCount = 1;
    
}

- (void)startRequestGetUrlString:(NSString *)aUrlString
                   responseBlock:(void (^)(NSURLSessionDataTask *task, id responseObject, NSError *error))responseBlock {
    
    
    [self.htmlService GET:aUrlString
               parameters:nil
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      
                      
                      
                      
                      responseBlock(task, responseObject, nil);
                      
                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                      
                      responseBlock(task,nil, error);
                      
                  }];
    
    
}


@end
