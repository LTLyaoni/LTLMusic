//
//  LTLDownloadMusic.h
//  音乐播放器
//
//  Created by 李泰良 on 16/12/16.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface LTLDownloadMusic : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger
{
    LTLDownloadMusicResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    LTLDownloadMusicResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    LTLDownloadMusicResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    LTLDownloadMusicResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
    
} LTLDownloadMusicResizingBehavior;

extern CGRect LTLDownloadMusicResizingBehaviorApply(LTLDownloadMusicResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+(void) drawDownloadMusic;
+(void) drawDownloadMusicWithFrame:(CGRect)frame resizing:(LTLDownloadMusicResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+(UIImage *) imageOfDownloadMusic;
+(UIImage *) imageOfDownloadMusicWithSize:(CGSize)size resizing:(LTLDownloadMusicResizingBehavior)resizing;


@end