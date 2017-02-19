//
//  AppDelegate.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/14.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLAppDelegate.h"
#import "LTLloginSet.h"
#import "LTLSearchController.h"
#import "LTLMainInterface.h"


//#import "MMDrawerController.h"
//#import "MMExampleDrawerVisualStateManager.h"

@interface LTLAppDelegate ()<XMReqDelegate>
@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic,strong) LTLMainInterface *mainVC;
///下载管理
@property(nonatomic,strong) XMSDKDownloadManager *download;
@property(nonatomic,assign,getter=isJihao)NSUInteger jihao;
@end

@implementation LTLAppDelegate

///懒加载下载管理
-(XMSDKDownloadManager *)download
{
    if (!_download) {
        _download = [XMSDKDownloadManager sharedSDKDownloadManager];
        
        [_download getDownloadedTracks];
    }
    return _download;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.jihao = 1;
    
    ///开启网络检测
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    
    
    
    // 在App启动后开启远程控制事件, 接收来自锁屏界面和上拉菜单的控制
//    [application beginReceivingRemoteControlEvents];
    ///注册喜马拉雅
    [self RegisteredHimalaya];

    
    ///////////////////////////////////////////
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self initView];
    
    ///显示窗口
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initView) name:LTLThemeKey object:nil];
    
    ///////////////////////////////
    UIImage *image = [UIImage imageNamed:@"Stars"];
//    ///window的layer层添加内容
//    self.window.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
//    self.window.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    imageV.frame = self.window.bounds;
//    [self.window insertSubview:imageV atIndex:0];
    
    //颜色
    [self zhuTi];
    
//    [self alliesToShare];
    
    return YES;
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSLog(@"LTL currentStatus:%@",@(status));
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)initView
{
//    self.window = nil;
    ///主视图
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"LTLMainInterface" bundle:nil];
    UINavigationController *mianController = [Storyboard instantiateInitialViewController];
    self.mainVC = (LTLMainInterface *) mianController.topViewController;
    ///右滑视图
    LTLloginSet *log = [[LTLloginSet alloc]initWithNibName:@"LTLloginSet" bundle:nil];
    
    ///////////////////////////////////////////
    ///第三方滑动菜单动画框架
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:mianController leftDrawerViewController:log];

    //    阴影
    self.drawerController.showsShadow = YES;
    //距离
    self.drawerController.maximumLeftDrawerWidth = LTL_WindowW*4/5;
    self.drawerController.maximumRightDrawerWidth = LTL_WindowW;
    //////设置抽屉的视觉状态
    ///旧
//    [self.drawerController
//     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager]
//                  drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
//     }];
    ///新
    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:3]];
    
    ///设置根控制器
    self.window.rootViewController = self.drawerController;
    //     self.window.rootViewController = mianController;
//    [self.window makeKeyAndVisible];

}



///设置主题色
-(void)zhuTi
{
    [UINavigationBar appearance].tintColor       = [LTLThemeManager sharedManager].themeColor;
    [UITabBar appearance].tintColor              = [LTLThemeManager sharedManager].themeColor;
//    [UINavigationBar appearance].backgroundColor = [UIColor clearColor];
}
////友盟分享 SDK
//-(void)alliesToShare
//{
//    //打开调试日志
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    //设置友盟appkey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"584e18d782b6356f17001414"];
//    
//    // 获取友盟social版本号
//    LTLLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
//    
//    //设置分享到QQ互联的appKey和appSecret
//    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"3pwdwdmTlW9UQsLL"  appSecret:nil redirectURL:@"http://user.qzone.qq.com/1184676257"];
//    
//    //设置新浪的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"487089634"  appSecret:@"42339cdd2f4feee9903780fbc93e96aa" redirectURL:@"https://api.weibo.com/oauth2/default.html"];
//    
//    //设置微信的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
//
//    
////    // 如果不想显示平台下的某些类型，可用以下接口设置
////        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_LaiWangTimeLine),@(UMSocialPlatformType_Qzone)]];
//    
//}
// 支持所有iOS系统
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
//        // 其他如支付等SDK的回调
//        LTLLog(@"回调%@",url);
//    }
//    return result;
//}
///喜马拉雅 SDK
-(void)RegisteredHimalaya
{
    
//    [[XMReqMgr sharedInstance]registerXMReqInfoWithKey:appkey appSecret:appsecret];
//    [XMReqMgr sharedInstance].delegate = self;
#if DEBUG
    [[XMReqMgr sharedInstance] registerXMReqInfoWithKey:appkey appSecret:appsecret] ;
#else
    [[XMReqMgr sharedInstance] registerXMReqInfoWithKey:appkey appSecret:appsecret] ;
#endif
    [XMReqMgr sharedInstance].delegate = self;
    
    [self.download getDownloadedTracks];
    
}


-(void)didXMInitReqFail:(XMErrorModel *)respModel{
    LTLLog(@"注册失败 %@", respModel);
}
-(void)didXMInitReqOK:(BOOL)result
{
    LTLLog(@"注册成功 %d" , result);
    if (result&&self.isJihao) {
        self.jihao = 0;
        ///设置根控制器
//        self.window.rootViewController = self.drawerController;
        [[NSNotificationCenter defaultCenter] postNotificationName:LTLRefreshKey object:nil userInfo:nil];
        
    }
}
// 接收到内存警告就会调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //    DDActionLog;
    
    // 1.停止当前下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 2.清空内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    ///喜马拉雅要求在App要终止前调用下面一句话
    [[XMReqMgr sharedInstance] closeXMReqMgr];
    // 在App要终止前结束接收远程控制事件, 也可以在需要终止时调用该方法终止
//    [application endReceivingRemoteControlEvents];
}


@end
