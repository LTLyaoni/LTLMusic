//
//  LTLplayHistory.h
//  音乐播放器
//
//  Created by 李泰良 on 16/12/16.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface LTLplayHistory : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger
{
    LTLplayHistoryResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    LTLplayHistoryResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    LTLplayHistoryResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    LTLplayHistoryResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
    
} LTLplayHistoryResizingBehavior;

extern CGRect LTLplayHistoryResizingBehaviorApply(LTLplayHistoryResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+(void) drawPlayHistory;
+(void) drawPlayHistoryWithFrame:(CGRect)frame resizing:(LTLplayHistoryResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+(UIImage *) imageOfPlayHistory;
+(UIImage *) imageOfPlayHistoryWithSize:(CGSize)size resizing:(LTLplayHistoryResizingBehavior)resizing;


@end
