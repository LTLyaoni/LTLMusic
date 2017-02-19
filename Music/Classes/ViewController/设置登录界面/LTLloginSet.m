//
//  LTLloginSet.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/26.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLloginSet.h"
#import "LTLmyDataCell.h"
#import "LTLListController.h"
#import "LTLThemeController.h"
#import "LTLMusicBackground.h"


@interface LTLloginSet ()<UITableViewDelegate,UITableViewDataSource>
///iconW
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconW;
///iconH
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabelW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabelH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *juLi;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
///背景
@property (weak, nonatomic) IBOutlet UIImageView *bj;

////////控件
@property (weak, nonatomic) IBOutlet UITableView *setTabel;
///数据
@property(nonatomic,strong) NSArray *myData;



@property(nonatomic,strong) LTLListController *list;

@property(nonatomic,strong) UINavigationController *NavList;


@end
static NSString *cellID = @"myDataCell";
@implementation LTLloginSet
#pragma mark - 懒加载

-(LTLListController *)list
{
    if (!_list) {
        _list = [[LTLListController alloc]init];
    }
    return _list;
}

-(UINavigationController *)NavList
{
    if (!_NavList) {
        _NavList = [[UINavigationController alloc]initWithRootViewController:self.list];
    }
    return _NavList;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [LTLMusicBackground imageOfMusicBackgroundWithSize:_bj.bounds.size resizing:LTLMusicBackgroundResizingBehaviorAspectFit];
    
    _bj.image = image;
//    _iconH.constant = LTL_WindowW /3.8;
//    _iconW.constant = LTL_WindowW /3.8;
    
    _iconH.constant = LTL_WindowW/10;
    _iconW.constant = 0;
    
    _tabelW.constant = LTL_WindowW*16/25;
    _juLi.constant = LTL_WindowW*2/25;
    
    _top.constant = LTL_WindowW/3.8;
    _tabelH.constant = LTL_WindowW;

    
    [_setTabel registerClass:[LTLmyDataCell class] forCellReuseIdentifier:cellID];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
//    [self.navigationController.view addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 懒加载
-(NSArray *)myData
{
    if (!_myData) {
        
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"myData" ofType:@"plist"];
        _myData = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        
    }
   return _myData;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTLmyDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.tag = indexPath.row;
    cell.act = self.myData[indexPath.row];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            self.list.listType = LTLListTypeLikeList;

            
            [self presentViewController:self.NavList animated:YES completion:^{
                
                ///收起菜单
//                [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
                
            }];
            
            break;
        }
        case 1:
            
        {
            self.list.listType = LTLListTypeHistoryList;
            
            
            [self presentViewController:self.NavList animated:YES completion:^{
                
                ///收起菜单
//                [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
                
            }];
        
            
            break;
        }
        case 2:
        {
            self.list.listType = LTLListTypeDownloaTrack;
            
            
            [self presentViewController:self.NavList animated:YES completion:^{
                
                ///收起菜单
//                [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
                
            }];
            
        
            break;
        }
        case 3:
        {
            
            LTLLog(@"换主题");
            
            LTLThemeController *VC = [[LTLThemeController alloc]init];
            
            UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:VC];
            
            [self presentViewController:na animated:YES completion:nil];
            
            break;
        }
        case 4:
            
        {
            float folderSize =  [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
            NSString *str = [NSString stringWithFormat:@"有%.2fM的缓存,确定要清理缓存吗？",folderSize];

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction* defaultAction0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive
                                                                   handler:^(UIAlertAction * action) {
                                                                       [self alertTextFiledDidChanged];
                                                                   }];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * action) {
                                                                       
                                                                   }];
            
            [alert addAction:defaultAction0];
            [alert addAction:defaultAction1];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            break;
        }
            
        case 5:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"关于L音乐" message:@"本应用为LTL的第一款应用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            break;
        }
            case 6:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"开发者" message:@"LTL 李泰良\n联系邮箱：1184676257@qq.com" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            break;
        }
        default:
            break;
    }
    
}

- (void)alertTextFiledDidChanged{
    
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];

    [SVProgressHUD showWithStatus:@"正在清理中"];
    
    
    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
       
        [SVProgressHUD setMinimumDismissTimeInterval:1.8];
        [SVProgressHUD showSuccessWithStatus:@"清理完成!"];
        
    }];
    

    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}
//-(void)dealloc
//{
//    [self removeObserver:self forKeyPath:@"alpha"];
//};

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if ([keyPath  isEqual: @"alpha"]) {
//     
//        LTLLog(@"LTL%f",self.navigationController.view.alpha);
//        
//        if (self.navigationController.view.alpha == 5) {
//
//            
//            
//        }
//        
//        
//    }
//}

- (IBAction)log:(UIButton *)sender {
    
//    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
    
}




//- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
//{
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
//        UMSocialUserInfoResponse *userinfo =result;
//        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        
//        
//        
//        
//        [alert show];
//    }];
//}





@end
