//
//  ViewController.m
//  LYSBmob
//
//  Created by 刘永生 on 16/7/31.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "ViewController.h"

#import "LYSBmobService.h"

#import <SVProgressHUD.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *bmobKeyTF;


@property (nonatomic, strong) LYSBmobService * service;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)touchBmobAndDB:(id)sender {
    
    _service = [[LYSBmobService alloc]init];
    
    _service.lys_BmobAppID = _bmobKeyTF.text;
    
}

- (IBAction)touchTabelStructure:(id)sender {
    
    [SVProgressHUD showWithStatus:@"获取表结构"];
    [_service lys_service_allTableStructureBlock:^(NSArray<BmobTableSchema *> *listArray, NSError *error) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.description];
        }else {
            [SVProgressHUD showSuccessWithStatus:@"获取表结构成功"];
            
            /**
             *  本地创建表
             */
            [GLYSBmobServiceDB lys_db_createTables:listArray];
        }
        
    }];
    
}



- (IBAction)touchCheckAllData:(id)sender {
    
    
    
    
    
    //    [service lys_CheckTableName:@"riddle"
    //                          block:^(NSMutableArray<BmobObject *> *listArray, NSError *error)
    //     {
    //         
    //         NSLog(@"listArray%@",listArray);
    //         
    //     }];
    //    
    
    
}







@end
