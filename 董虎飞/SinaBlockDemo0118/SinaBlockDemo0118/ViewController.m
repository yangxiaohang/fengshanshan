//
//  ViewController.m
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "HTTPRequest.h"
#import "FriendTableViewCell.h"
#import "FriendModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)HTTPRequest *request;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if ([HTTPRequest isNeedLogin]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
        [loginVC setGetAccessTokenSuccess:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _request = [[HTTPRequest alloc]init];
                
                [_request setGetFriendTimeLineSuccess:^(NSArray *array) {
                    
                    self.dataArr = [array mutableCopy];
                    
                    [self.tableView reloadData];
                    
                }];
                
                [_request getFriendsTimeLine];

            });
            
        }];
        
        [self presentViewController:loginVC animated:YES completion:^{
            [loginVC release];
        }];

    }else{
        
        _request = [[HTTPRequest alloc]init];
        
        [_request setGetFriendTimeLineSuccess:^(NSArray *array) {
            
            self.dataArr = [array mutableCopy];
            
            [self.tableView reloadData];
            
        }];
        
        [_request getFriendsTimeLine];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArr = [NSMutableArray array];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    [self.tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"FriendTableViewCell" owner:nil options:nil];
//    
//    cell = [arr firstObject];
    
    FriendModel *friend = self.dataArr[indexPath.row];
    
    cell.touxiang.image = [UIImage imageWithData:friend.picData];
    cell.nameLabel.text = friend.name;
    cell.sourceLabel.text = friend.source;
    cell.contentLabel.text = friend.text;
    
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_request release];
    [_dataArr release];
    [_tableView release];
    [super dealloc];
}
@end
