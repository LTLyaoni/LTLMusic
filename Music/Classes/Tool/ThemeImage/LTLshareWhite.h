//
//  LTLshareWhite.h
//  音乐播放器
//
//  Created by 李泰良 on 16/12/10.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface LTLshareWhite : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger
{
    LTLshareWhiteResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    LTLshareWhiteResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    LTLshareWhiteResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    LTLshareWhiteResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
    
} LTLshareWhiteResizingBehavior;

extern CGRect LTLshareWhiteResizingBehaviorApply(LTLshareWhiteResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+(void) drawArtboard;
+(void) drawArtboardWithFrame:(CGRect)frame resizing:(LTLshareWhiteResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+(UIImage *) imageOfArtboard;
+(UIImage *) imageOfArtboardWithSize:(CGSize)size resizing:(LTLshareWhiteResizingBehavior)resizing;


@end
