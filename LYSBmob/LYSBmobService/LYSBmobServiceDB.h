//
//  LYSBmobServiceDB.h
//  LYSBmob
//
//  Created by 刘永生 on 16/8/2.
//  Copyright © 2016年 刘永生. All rights reserved.
//
/**
 *  本地数据存储
 */
#import <Foundation/Foundation.h>


#import "NSString+LYSPath.h"

#import <FMDB.h>
//#import <BmobSDK/Bmob.h>

@class BmobObject;
@class BmobTableSchema;

#define GLYSBmobServiceDB [LYSBmobServiceDB sharedManager]

@interface LYSBmobServiceDB : NSObject

@property (nonatomic, copy) NSString *lys_DBPath;/**< 数据库路径,并创建数据库 */
@property (nonatomic, strong) FMDatabase *lys_DB;/**< 数据库 */

+ (LYSBmobServiceDB *)sharedManager;

- (void)lys_db_createTables:(NSArray <BmobTableSchema *> *)aTabeles ;



/**
 *  插入bmobObjects
 */
- (void)insertBmobObjects:(NSArray <BmobObject *> *)aBmobObjects;

/**
 *  更新BmobObject
 */
- (void)updateBmobObjects:(NSArray <BmobObject *> *)aBmobObjects;






@end
