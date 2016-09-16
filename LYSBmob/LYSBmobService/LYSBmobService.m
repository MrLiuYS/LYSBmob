//
//  LYSBmobService.m
//  LYSBmob
//
//  Created by 刘永生 on 16/7/31.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSBmobService.h"


#define kLimitNumber 50

@implementation LYSBmobService

+ (LYSBmobService *)sharedManager
{
    static LYSBmobService *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[LYSBmobService alloc]init];
        }
    });
    return sharedInstance;
}

- (void)setLys_BmobAppID:(NSString *)lys_BmobAppID {
    
    _lys_BmobAppID = lys_BmobAppID;
    
    [Bmob registerWithAppKey:lys_BmobAppID];
    
    NSLog(@"文档路径:%@",[NSString lys_documentsPath]);
    
    GLYSBmobServiceDB.lys_DBPath = [NSString stringWithFormat:@"%@/%@.db",
                                    [NSString lys_documentsPath],
                                    lys_BmobAppID];
}




#pragma mark - 查

/**
 *  下载表中所有的数据
 */
- (void)lys_CheckTableName:(NSString *)aTableName
                     block:(void (^)(NSMutableArray <BmobObject *>* listArray, NSError *error))block {
    
    
    NSMutableArray * saveArray = [NSMutableArray array];
    
    
    [self lys_CheckTableName:aTableName
                   saveArray:saveArray
                       block:^(NSMutableArray<BmobObject *> *listArray, NSError *error) {
                           
                           block(listArray,error);
                           
                       }];
    
    
}


- (void)lys_CheckTableName:(NSString *)aTableName
                    params:(NSDictionary *)aParams
                     block:(void (^)(NSMutableArray <BmobObject *>* listArray, NSError *error))block {
    
    
    
    
}

- (void)lys_CheckTableName:(NSString *)aTableName
                 saveArray:(NSMutableArray <BmobObject *>*)aSaveArray
                     block:(void (^)(NSMutableArray <BmobObject *>* listArray, NSError *error))block
{
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:aTableName];
    
    bquery.limit = kLimitNumber;
    
    bquery.skip = aSaveArray.count ;
    
    NSLog(@"skip:%ld",(long)bquery.skip);
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error) {
            
            NSLog(@"error:%@",error);
            
            [self lys_CheckTableName:aTableName
                           saveArray:aSaveArray
                               block:^(NSMutableArray<BmobObject *> *listArray, NSError *error) {
                                   
                                   block(aSaveArray,error);
                                   
                               }];
            
        }else {
            
            
            if (array.count) {
                
                BmobObject *obj = array[0];
                
                NSLog(@"%@",obj.objectId);
                
                [aSaveArray addObjectsFromArray:array];
                
                [self lys_CheckTableName:aTableName
                               saveArray:aSaveArray
                                   block:^(NSMutableArray<BmobObject *> *listArray, NSError *error) {
                                       
                                       block(aSaveArray,error);
                                       
                                   }];
                
            }else {
                
                block(aSaveArray,error);
            }
            
        }
        
    }];
    
}


#pragma mark - 获取所有表结构
- (void)lys_service_allTableStructureBlock:(void (^)(NSArray <BmobTableSchema *>* listArray, NSError *error))block {
    
    
    [Bmob getAllTableSchemasWithCallBack:^(NSArray *tableSchemasArray, NSError *error) {
        
        block(tableSchemasArray, error);
        
        
        
    }];
    
}




@end
