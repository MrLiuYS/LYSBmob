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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    int _page_jzw;
    
}

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
            
            _page_jzw = 0;
            
            [self htmlService_jzw];
            
        }
            break;
            
        default:
            break;
    }
    
    
}


- (void)htmlService_jzw {
    
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"请求数据\npsp.asp?page=%d",_page_jzw]];
    
    [LYSHtmlService htmlService_JZW_GetUrlString:[NSString stringWithFormat:@"psp.asp?page=%d",_page_jzw]
                                   responseBlock:^(NSURLSessionDataTask *task, NSMutableArray<NSDictionary *> *responseArray, NSError *error) {
                                       
                                       if (responseArray.count > 0) {
                                           
                                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                               
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   
                                                   
                                                   [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"同步\npsp.asp?page=%d",_page_jzw]];
                                                   
                                                   [GLYSBmob lys_AddTableName:@"jzw"
                                                              Lessthan50Array:responseArray
                                                                  resultBlock:^(BOOL isSuccessful, NSError *error) {
                                                                      
                                                                      [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"同步成功\npsp.asp?page=%d",_page_jzw]];
                                                                      
                                                                      if (isSuccessful) {
                                                                          _page_jzw+=1;
                                                                      }
                                                                      
                                                                      [self performSelector:@selector(htmlService_jzw)
                                                                                 withObject:nil
                                                                                 afterDelay:0.1];
                                                                      
                                                                      
                                                                  }];
                                                   
                                                   
                                               });
                                               
                                               
                                           });
                                           
                                           
                                       }
                                       
                                       
                                   }];
    
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
