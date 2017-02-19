//
//  LTLThemeManager.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/26.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLThemeManager.h"

//#define LTLThemeColorKey @"themeColorKey";
NSString *const LTLThemeColorKey =  @"themeColorKey";

@implementation LTLThemeManager
{
    UIColor *_themeColor;
}
#pragma mark - 单例
//单例
+ (instancetype)sharedManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
-(UIColor *)themeColor
{
    if (!_themeColor)
    {
        ///默认
        _themeColor = [UIColor blueColor];
        ///取出偏好设置
        NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
        ///判断是否有主题色的偏好设置并转换为颜色
        if (defaults[LTLThemeColorKey]) {
            _themeColor = [ UIColor colorFromHexString:defaults[LTLThemeColorKey]];
        }
        
    }
    return _themeColor;
}

-(void)setThemeColor:(UIColor *)themeColor
{
    _themeColor = themeColor;
    ///把主题色转成16进制并储存偏好设置
    NSString *themeColorHexadecimal = [themeColor hexString];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:themeColorHexadecimal forKey:LTLThemeColorKey];
    
}


@end
