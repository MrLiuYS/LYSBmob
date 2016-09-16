//
//  ViewController.m
//  LYSBmob
//
//  Created by 刘永生 on 16/7/31.
//  Copyright © 2016年 刘永生. All rights reserved.
//

#import "ViewController.h"

#import "LYSHtmlConfige.h"

#import "LYSBmobService.h"

#import <Masonry.h>
#import <SVProgressHUD.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *bmobKeyTF;


@property (nonatomic, strong) LYSBmobService * service;


@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GLYSHtml;
    
    
    [self.view addSubview:self.mainTableView];
    
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.top.right.bottom.left.mas_equalTo(self.view);
        
    }];
    
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



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return LYSHtmlServiceType_MAX;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    switch (indexPath.row) {
        case LYSHtmlServiceType_JZW:
            cell.textLabel.text = @"jzw";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case LYSHtmlServiceType_JZW:
        {
            GLYSHtml.htmlUrlString = @"";
            
            GLYSBmob.lys_BmobAppID = @"";
            
            
            
            [LYSHtmlService htmlService_JZW_GetUrlString:@"psp.asp"
                                           responseBlock:^(NSURLSessionDataTask *task, NSMutableArray<NSDictionary *> *responseArray, NSError *error) {
                                               
                                               if (responseArray.count > 0) {
                                                   
                                                   
                                                   
                                               }
                                               
                                               
                                           }];
            
            
        }
            break;
            
        default:
            break;
    }
    
    
}


#pragma proprety 

- (UITableView *)mainTableView {
    
    if(!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}



@end
