//
//  LYSHtmlService.h
//  LYSBmob
//
//  Created by 刘永生 on 16/9/15.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <GDataXMLNode.h>


typedef enum
{
    LYSHtmlServiceType_JZW = 0,
    
    LYSHtmlServiceType_MAX
}
LYSHtmlServiceType;


#define GLYSHtml [LYSHtmlService sharedManager]

@interface LYSHtmlService : NSObject



@property (nonatomic,copy) NSString *htmlUrlString;

+ (LYSHtmlService *)sharedManager;

- (void)startRequestGetUrlString:(NSString *)aUrlString
                   responseBlock:(void (^)(NSURLSessionDataTask *task, id responseObject, NSError *error))responseBlock;



@end
