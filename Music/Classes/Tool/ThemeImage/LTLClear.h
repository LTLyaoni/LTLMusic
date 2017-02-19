//
//  LTLClear.h
//  音乐播放器
//
//  Created by 李泰良 on 16/12/16.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface LTLClear : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger
{
    LTLClearResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    LTLClearResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    LTLClearResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    LTLClearResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
    
} LTLClearResizingBehavior;

extern CGRect LTLClearResizingBehaviorApply(LTLClearResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+(void) drawClear;
+(void) drawClearWithFrame:(CGRect)frame resizing:(LTLClearResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+(UIImage *) imageOfClear;
+(UIImage *) imageOfClearWithSize:(CGSize)size resizing:(LTLClearResizingBehavior)resizing;


@end