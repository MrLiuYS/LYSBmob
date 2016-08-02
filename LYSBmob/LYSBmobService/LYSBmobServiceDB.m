//
//  LYSBmobServiceDB.m
//  LYSBmob
//
//  Created by 刘永生 on 16/8/2.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "LYSBmobServiceDB.h"

#import "LYSBmobService.h"

@implementation LYSBmobServiceDB

+ (LYSBmobServiceDB *)sharedManager
{
    static LYSBmobServiceDB *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[LYSBmobServiceDB alloc]init];
        }
    });
    return sharedInstance;
}

- (void)setLys_DBPath:(NSString *)lys_DBPath {
    
    _lys_DBPath = lys_DBPath;
    
    _lys_DB = [FMDatabase databaseWithPath:_lys_DBPath];
    if ([_lys_DB open]) {
        [_lys_DB close];
    }
    
}

- (void)lys_db_createTables:(NSArray <BmobTableSchema *> *)aTabeles {
    
    NSMutableArray *tableArray = [NSMutableArray array];
    
    //    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:self.lys_DBPath];
    
    
    //    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];  
    
    NSMutableString *tableString = [NSMutableString string];
    
    
    for (BmobTableSchema* bmobTableSchema in aTabeles) {
        //直接用description来查看表结构
        NSLog(@"%@",bmobTableSchema.description);
        
        /*
         分别打印表结构
         */
        //打印表名
        NSLog(@"表名:%@",bmobTableSchema.className);
        //打印表结构
        NSDictionary *fields = bmobTableSchema.fields;
        NSArray *allKey = [fields allKeys];
        for (NSString *key in allKey) {
            NSLog(@"列名:%@",key);
            NSDictionary *fieldStrcut = [fields objectForKey:key];
            NSLog(@"列类型:%@",[fieldStrcut objectForKey:@"type"] );
            if ([[fieldStrcut objectForKey:@"type"] isEqualToString:@"Pointer"]) {
                NSLog(@"关联关系指向的表名:%@",[fieldStrcut objectForKey:@"targetClass"]);
            }
        }
    }
    
    [_lys_DB open];
    
    for (NSString * tableStr in tableArray) {
        
        BOOL res = [_lys_DB executeUpdate:tableStr];
        
        if (!res) {
            
            NSLog(@"error when creating db table");
            
        } else {
            
            NSLog(@"success to creating db table");
            
        }
        
    }
    
    [_lys_DB close];
    
}






@end
