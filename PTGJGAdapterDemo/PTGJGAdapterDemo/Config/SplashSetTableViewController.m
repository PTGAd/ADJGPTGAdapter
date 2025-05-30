//
//  SplashSetTableViewController.m
//  ADJgDev
//
//  Created by Erik on 2021/4/25.
//

#import "SplashSetTableViewController.h"
#import "SetConfigManager.h"
@interface SplashSetTableViewController ()
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation SplashSetTableViewController

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [UISwitch new];
    }
    return _switchBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开屏设置";
    UIButton *setAdConfigBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [setAdConfigBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [setAdConfigBtn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    setAdConfigBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    setAdConfigBtn.frame = CGRectMake(0, 0, 50, 20);
    [setAdConfigBtn addTarget:self action:@selector(saveSetConfig) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:setAdConfigBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    self.tableView.tableFooterView = [UIView new];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)saveSetConfig {
    [SetConfigManager sharedManager].isCustomSkipView = self.switchBtn.on;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithRed:225/255.0 green:233/255.0 blue:239/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"";
    label.textColor = UIColor.grayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    cell.textLabel.text = @"自定义跳过按钮";
    cell.accessoryView = self.switchBtn;
    self.switchBtn.on = [SetConfigManager sharedManager].isCustomSkipView = nil ? NO : [SetConfigManager sharedManager].isCustomSkipView;
    return cell;
}

@end
