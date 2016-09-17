//
//  LYSHtmlService+MINGYAN.m
//  LYSBmob
//
//  Created by 刘永生 on 16/9/17.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSHtmlService+MINGYAN.h"

@implementation LYSHtmlService (MINGYAN)

+ (void) htmlService_MINGYAN_GetUrlString:(NSString *)aUrlString
                            responseBlock:(void (^)(NSURLSessionDataTask *task, NSMutableArray <NSDictionary *>* responseArray, NSError *error))responseBlock {
    
    [GLYSHtml startRequestGetUrlString:aUrlString
                         responseBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                             
                             if (responseObject) {
                                 
                                 responseBlock(task , [self resolve_MINGYAN_Response:responseObject] , nil);
                                 
                             }else {
                                 
                                 responseBlock(task, nil , error);
                                 
                             }
                             
                         }];
    
    
}

+ (NSMutableArray *)resolve_MINGYAN_Response:(id)responseObject {
    
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
                
                
                NSMutableDictionary * pDic = [NSMutableDictionary dictionary];
                
                NSArray * td = [item1 elementsForName:@"td"];
                
                if (td.count == 2) {
                    
                    GDataXMLElement * first = [td firstObject];
                    
                    {
                        NSArray * a = [first  elementsForName:@"a"];
                        
                        if (a) {
                            
                            for (GDataXMLElement * element in a) {
                                
                                [pDic setObject:[[element attributeForName:@"href"] stringValue] forKey:@"href"];
                                [pDic setObject:element.stringValue forKey:@"topic"];
                                
                            }
                            
                        }
                    }
                    
                    
                    GDataXMLElement * last = [td lastObject];
                    
                    [pDic setObject:last.stringValue forKey:@"author"];
                    
                }
                
                [mainArray addObject:pDic];
                
            }
            
            
        }
        
        
        
        
    }
    
    return mainArray;
    
}



@end
