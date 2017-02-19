//
//  LTLmyDataCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/9.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLmyDataCell.h"
#import "LTLplayHistory.h"
#import "LTLDownloadMusic.h"
#import "LTLlikeList.h"
#import "LTLskin.h"
#import "LTLClear.h"
#import "LTLcontact.h"
#import "LTLabout.h"

@interface LTLmyDataCell ()
@property(nonatomic,strong) UIImageView *coverIV;

@property (nonatomic,strong) UILabel *titleLb;
@end

@implementation LTLmyDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAct:(NSDictionary *)act{
    
    _act = act;
    self.titleLb.text = _act[@"title"];
    
//    UIImage *image = [[]]
    
//    self.coverIV.image = [UIImage imageNamed:_act[@"image"]];
}

-(void)setTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
            
            self.coverIV.image = [LTLlikeList imageOfLikeListWithSize:CGSizeMake(38, 38) resizing:LTLlikeListResizingBehaviorAspectFit];
            break;
        case 1:
            
            self.coverIV.image = [LTLplayHistory imageOfPlayHistoryWithSize:CGSizeMake(38, 38) resizing:LTLplayHistoryResizingBehaviorAspectFit];
            break;
        case 2:
            self.coverIV.image = [LTLDownloadMusic imageOfDownloadMusicWithSize:CGSizeMake(38, 38) resizing:LTLDownloadMusicResizingBehaviorAspectFit];
            break;
        case 3:
            self.coverIV.image = [LTLskin imageOfSkinWithSize:CGSizeMake(38, 38) resizing:LTLskinResizingBehaviorAspectFit];
            break;
        case 4:
            self.coverIV.image = [LTLClear imageOfClearWithSize:CGSizeMake(38, 38) resizing:LTLClearResizingBehaviorAspectFit];
            break;
        case 5:
            self.coverIV.image = [LTLabout imageOfAboutWithSize:CGSizeMake(38, 38) resizing:LTLaboutResizingBehaviorAspectFit];
            break;
        case 6:
            self.coverIV.image = [LTLcontact imageOfContactWithSize:CGSizeMake(38, 38) resizing:LTLcontactResizingBehaviorAspectFit];
            break;
        default:
            break;
    }

}

#pragma mark - 懒加载
- (UIImageView *)coverIV {
    
    if(_coverIV == nil) {
        _coverIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_coverIV];
        [_coverIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(20);
        }];
        
    }
    return _coverIV;
}

- (UILabel *)titleLb {
    
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}


@end
