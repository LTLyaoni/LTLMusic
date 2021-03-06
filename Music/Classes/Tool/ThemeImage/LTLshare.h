//
//  LTLshare.h
//  音乐播放器
//
//  Created by 李泰良 on 16/11/26.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface LTLshare : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger
{
    LTLshareResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    LTLshareResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    LTLshareResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    LTLshareResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
    
} LTLshareResizingBehavior;

extern CGRect LTLshareResizingBehaviorApply(LTLshareResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+(void) drawArtboard;
+(void) drawArtboardWithFrame:(CGRect)frame resizing:(LTLshareResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+(UIImage *) imageOfArtboard;
+(UIImage *) imageOfArtboardWithSize:(CGSize)size resizing:(LTLshareResizingBehavior)resizing;


@end
