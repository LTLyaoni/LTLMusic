//
//  LTLThemeController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/14.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLThemeController.h"
#import "LSLHSBColorPickerView.h"
@interface LTLThemeController ()

@property (weak, nonatomic) IBOutlet LSLHSBColorPickerView *colorPickerView;


@property (weak, nonatomic) IBOutlet UIView *shiFan;

@property (nonatomic,strong)UIButton *leftBarButton;
@property (nonatomic,strong)UIButton *rightBarButton;

@end

@implementation LTLThemeController

-(UIButton *)leftBarButton
{
    if (!_leftBarButton) {
        _leftBarButton = [[UIButton alloc]init];
        [_leftBarButton setTitle:@"返回" forState:UIControlStateNormal];
         [_leftBarButton setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
        [_leftBarButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_leftBarButton sizeToFit];
    }
    return _leftBarButton;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    

}


-(UIButton *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [[UIButton alloc]init];
        [_rightBarButton setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBarButton setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
        
        [_rightBarButton addTarget:self action:@selector(determine) forControlEvents:UIControlEventTouchUpInside];
        
        [_rightBarButton sizeToFit];
    }
    return _rightBarButton;
}
-(void)determine
{
    LTLLog(@"L%@",self.colorPickerView.preColor);
    LTLLog(@"LL%@",self.colorPickerView.color);
    [self.colorPickerView saveSelectedColorToArchiver];

    [UINavigationBar appearance].tintColor = self.colorPickerView.color;
    
    [LTLThemeManager sharedManager].themeColor = self.colorPickerView.color;
    
    LTLLog(@"T%@",self.colorPickerView.preColor);
    
//    [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeGradient];
    
//    SVProgressHUD *HD = [[SVProgressHUD alloc]init];
//    
//    [HD setDefaultMaskType:SVProgressHUDMaskTypeGradient];

    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
//
//    [win addSubview:jieTu];
//
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//    [SVProgressHUD showWithStatus:@"LTL"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLThemeKey object:nil];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showWithStatus:@"更换主题中"];
    
    UIView *kuaiZhao =  [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    
    [win addSubview:kuaiZhao];
    [win bringSubviewToFront:kuaiZhao];
    
    LTLLog(@"jkhsdirjji");
    [self dismissViewControllerAnimated:NO completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 处理耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            ///动画
            [UIView animateWithDuration:0.8 animations:^{
    
                kuaiZhao.transform = CGAffineTransformScale(kuaiZhao.transform, 0.1, 0.1);
                kuaiZhao.alpha = 0;
            }completion:^(BOOL finished) {
                [kuaiZhao removeFromSuperview];
            }];
            
        });
    });
    
}

-(void)dealloc
{
    LTLLog(@"销毁");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBarButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBarButton];
    
    self.title = @"更改主题色";
    
    self.shiFan.backgroundColor = self.colorPickerView.preColor;
    
    LTLWeakSelf
    [self.colorPickerView colorSelectedBlock:^(UIColor *color, BOOL isConfirm) {
        
//        LTLLog(@"%@,%d",color,isConfirm);r
        
        weakSelf.shiFan.backgroundColor = color;
        [self.rightBarButton setTitleColor:color forState:UIControlStateNormal];
        [self.leftBarButton setTitleColor:color forState:UIControlStateNormal];
        
        if (isConfirm) {
            LTLLog(@"%@",color);
        }
        
    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
