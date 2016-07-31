//
//  LYSBmobService.m
//  LYSBmob
//
//  Created by 刘永生 on 16/7/31.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSBmobService.h"




@implementation LYSBmobService

- (void)setLys_BmobAppID:(NSString *)lys_BmobAppID {
    
    _lys_BmobAppID = lys_BmobAppID;
    [Bmob registerWithAppKey:lys_BmobAppID];
    
}



@end
