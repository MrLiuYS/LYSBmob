//
//  LYSHtmlService+JZW.m
//  LYSBmob
//
//  Created by 刘永生 on 16/9/16.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSHtmlService+JZW.h"

@implementation LYSHtmlService (JZW)


+ (void) htmlService_JZW_GetUrlString:(NSString *)aUrlString
                        responseBlock:(void (^)(NSURLSessionDataTask *task, NSMutableArray <NSDictionary *>* responseArray, NSError *error))responseBlock {
    
    [GLYSHtml startRequestGetUrlString:aUrlString
                         responseBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                             
                             if (responseObject) {
                                 
                                 responseBlock(task , [self resolveResponse:responseObject] , nil);
                                 
                             }else {
                                 
                                 responseBlock(task, nil , error);
                                 
                             }
                             
                         }];
    
    
}

+ (NSMutableArray *)resolveResponse:(id)responseObject {
    
    NSMutableArray * mainArray = [NSMutableArray array];
    
    GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithHTMLData:responseObject
                                                              encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
                                                                 error:NULL];
    
    if (doc) {
        
        NSArray * trArray = [doc nodesForXPath:@"//table" error:NULL];
        
        for (GDataXMLElement * item2 in trArray)
        {
            
            NSArray * tr = [item2 elementsForName:@"tr"];
            
            for (GDataXMLElement * item1 in tr) {
                
                
                NSMutableDictionary * jzwDic = [NSMutableDictionary dictionary];
                
                NSArray * td = [item1 elementsForName:@"td"];
                
                for (GDataXMLElement * item3 in td) {
                    
                    NSArray * a = [item3  elementsForName:@"a"];
                    
                    if (a) {
                        
                        for (GDataXMLElement * element in a) {
                            
                            [jzwDic setObject:[[element attributeForName:@"href"] stringValue] forKey:@"href"];
                            
                        }
                        
                    }else {
                        
                        [jzwDic setObject:item3.stringValue forKey:@"topic"];
                        
                    }
                    
                }
                
                [mainArray addObject:jzwDic];
                
            }
            
            
        }
        
        
        
        
    }
    
    return mainArray;
    
}






@end
