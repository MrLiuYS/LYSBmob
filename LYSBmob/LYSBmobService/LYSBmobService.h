//
//  LYSBmobService.h
//  LYSBmob
//
//  Created by 刘永生 on 16/7/31.
//  Copyright © 2016年 刘永生. All rights reserved.
//
/**
 *  Bmob网络请求
 */
#import <Foundation/Foundation.h>

#import <BmobSDK/Bmob.h>


#import "LYSBmobServiceDB.h"

//static NSString *const kBmobTable             = @"kBmobTable";
static NSString *const kBmobTableSyncIden             = @"kBmobTableSyncIden";



@interface LYSBmobService : NSObject

/**
 *  设置bmob id , 并注册
 */
@property (nonatomic,copy) NSString *lys_BmobAppID;

#pragma mark - 增


#pragma mark - 删


#pragma mark - 改

- (void)lys_service_UpdateTableName:(NSString *)aTableName
                             params:(NSDictionary *)aParams
                              block:(void (^)(NSMutableArray <BmobObject *>* listArray, NSError *error))block;

#pragma mark - 查

/**
 *  下载表中所有的数据
 */
- (void)lys_service_checkTableName:(NSString *)aTableName
                             block:(void (^)(NSMutableArray <BmobObject *>* listArray, NSError *error))block;


- (void)lys_service_CheckTableName:(NSString *)aTableName
                            params:(NSDictionary *)aParams
                             block:(void (^)(NSMutableArray <BmobObject *>* listArray, NSError *error))block;


/**
 *  获取所有表结构
 */
- (void)lys_service_allTableStructureBlock:(void (^)(NSArray <BmobTableSchema *>* listArray, NSError *error))block;









@end
