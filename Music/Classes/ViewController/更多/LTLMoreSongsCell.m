//
//  LTLMoreSongsCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMoreSongsCell.h"

@interface LTLMoreSongsCell ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *icon;
//专辑名
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *xiaingqing;
/** 播放次数标签 */
@property (weak, nonatomic) IBOutlet UILabel *playCountLb;
//专辑歌数
@property (weak, nonatomic) IBOutlet UILabel *songNum;


@end

@implementation LTLMoreSongsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置cell被选中后的背景色
    UIView *view=[UIView new];
    view.backgroundColor=LTL_RGBColor(243, 255, 254);
    self.selectedBackgroundView=view;
    //分割线距离左侧空间
    self.separatorInset=UIEdgeInsetsMake(0, 76, 0, 0);
    
    
    //设置阴影的颜色
    _icon.layer.shadowColor=[UIColor blackColor].CGColor;
    //设置阴影的偏移量，如果为正数，则代表为往右边偏移
    _icon.layer.shadowOffset=CGSizeMake(5, 5);
    //设置阴影的透明度(0~1之间，0表示完全透明)
    _icon.layer.shadowOpacity=0.5;
    
}

-(void)setAlbum:(XMAlbum *)album
{
    _album = album;

    NSURL *url = [NSURL URLWithString:_album.coverUrlLarge];
    [_icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    _name.text = _album.albumTitle;
    _xiaingqing.text = _album.albumIntro;
    _playCountLb.text = _album.playNumber;
    _songNum.text = [NSString stringWithFormat:@"%ld集",_album.includeTrackCount];
}

@end
