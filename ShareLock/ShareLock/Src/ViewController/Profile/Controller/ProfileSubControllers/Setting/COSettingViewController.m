//
//  COSettingViewController.m
//  ShareLock
//
//  Created by 陈区 on 2017/7/6.
//  Copyright © 2017年 陈区. All rights reserved.
//

#import "COSettingViewController.h"
#import "XBConst.h"
#import "COSettingCell.h"
#import "COSettingItemModel.h"
#import "COSettingSectionModel.h"
#import "WebViewController.h"


@interface COSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/**< section模型数组*/
@property (nonatomic,strong) NSArray  *sectionArray;


@end

@implementation COSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupFooterView];
    [self setupSections];
}



#pragma - mark viewSetup



- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(kLeftSpace, 20, kScreenWidth - 2*kLeftSpace, 40);
    settingBtn.backgroundColor = kThemeColor;
    [settingBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingBtn.titleLabel.font = kFontSizeThree;
    [settingBtn addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:settingBtn];
    
    self.tableView.tableFooterView = footerView;
    
    
    
}

- (void)setupSections
{
    //************************************section1
    COSettingItemModel *item1 = [[COSettingItemModel alloc]init];
    item1.funcName = @"清楚缓存";
    item1.executeCode = ^{
        [self putBufferBtnClicked];

    };
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    COSettingItemModel *item2 = [[COSettingItemModel alloc]init];
    item2.funcName = @"关于我们";
    item2.executeCode = ^{
        [self aboutUs];
    };
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    COSettingSectionModel *section1 = [[COSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2];
    
    //************************************section2
    
    COSettingItemModel *item4 = [[COSettingItemModel alloc]init];
    item4.funcName = @"用户协议";
    item4.executeCode = ^{
        [self userAgreement];
    };
    item4.detailImage = [UIImage imageNamed:@"icon-new"];
    item4.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    COSettingItemModel *item5 = [[COSettingItemModel alloc]init];
    item5.funcName = @"押金说明";
    item5.executeCode = ^{
        [self pledgeExplain];
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    COSettingSectionModel *section2 = [[COSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item4,item5];
    
    
    self.sectionArray = @[section1,section2];
    
    
}



#pragma mark - buttion

//退出登录
-(void)logoutAction:(UIButton *)sender{
    
//    [self.navigationController popToRootViewControllerAnimated:YES];

    [[BusinessManager sharedManager].systemAccountManager requesLogOut:^(NSDictionary *dict) {
//        if ([dict[@"ret"] intValue] == 0) {//退出成功
//        }
    } failure:^{
        
    }];
}

//关于我们
-(void)aboutUs{
    WebViewController *webViewCtr = [[WebViewController alloc]init];
    webViewCtr.webURL = @"http://www.baidu.com";
    [self.navigationController pushViewController:webViewCtr animated:YES];
}

//用户协议
-(void)userAgreement{
    WebViewController *webViewCtr = [[WebViewController alloc]init];
    webViewCtr.webURL = @"http://www.baidu.com";
    [self.navigationController pushViewController:webViewCtr animated:YES];
}

//押金说明
-(void)pledgeExplain{
    WebViewController *webViewCtr = [[WebViewController alloc]init];
    webViewCtr.webURL = @"http://www.baidu.com";
    [self.navigationController pushViewController:webViewCtr animated:YES];
}

//清除缓存按钮的点击事件
- (void)putBufferBtnClicked{
    CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
    
    NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.2fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.2fK, 删除缓存", size * 1024.0];
    
    message = @"确定清除本地缓存";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"清除" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//        [self cleanCaches];
        //获取完整路径
        NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
        [self cleanCaches:path];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self showDetailViewController:alert sender:nil];
}

// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    COSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"setting";
    COSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    COSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    COSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[COSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.item = itemModel;
    return cell;
}

#pragma - mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    COSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.sectionHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    COSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    COSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    if (itemModel.executeCode) {
        itemModel.executeCode();
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    COSettingSectionModel *sectionModel = [self.sectionArray firstObject];
    CGFloat sectionHeaderHeight = sectionModel.sectionHeaderHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
