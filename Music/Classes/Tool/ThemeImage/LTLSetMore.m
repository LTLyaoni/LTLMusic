//
//  LTLSetMore.m
//  音乐播放器
//
//  Created by 李泰良 on 16/11/26.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;
#import "LTLSetMore.h"



@implementation LTLSetMore


#pragma mark - Canvas Drawings

//! Page 1

+(void) drawArtboard
{
    [LTLSetMore drawArtboardWithFrame:CGRectMake(0, 0, 39, 39) resizing:LTLSetMoreResizingBehaviorAspectFit];
}

+(void) drawArtboardWithFrame:(CGRect)frame resizing:(LTLSetMoreResizingBehavior)resizing
{
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize To Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = LTLSetMoreResizingBehaviorApply(resizing, CGRectMake(0, 0, 39, 39), frame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGSize resizedScale = CGSizeMake(resizedFrame.size.width / 39, resizedFrame.size.height / 39);
    CGContextScaleCTM(context, resizedScale.width, resizedScale.height);
    
    //! Shape
    UIBezierPath *shape = [UIBezierPath bezierPath];
    [shape moveToPoint:CGPointMake(1, 2)];
    [shape addLineToPoint:CGPointMake(31, 2)];
    [shape addCurveToPoint:CGPointMake(32, 1) controlPoint1:CGPointMake(31.55, 2) controlPoint2:CGPointMake(32, 1.55)];
    [shape addCurveToPoint:CGPointMake(31, 0) controlPoint1:CGPointMake(32, 0.45) controlPoint2:CGPointMake(31.55, 0)];
    [shape addLineToPoint:CGPointMake(1, 0)];
    [shape addCurveToPoint:CGPointMake(0, 1) controlPoint1:CGPointMake(0.45, 0) controlPoint2:CGPointMake(0, 0.45)];
    [shape addCurveToPoint:CGPointMake(1, 2) controlPoint1:CGPointMake(0, 1.55) controlPoint2:CGPointMake(0.45, 2)];
    [shape addLineToPoint:CGPointMake(1, 2)];
    [shape closePath];
    [shape moveToPoint:CGPointMake(1, 2)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 3.67, 8);
    shape.usesEvenOddFillRule = YES;
    [[LTLThemeManager sharedManager].themeColor setFill];
    [shape fill];
    CGContextRestoreGState(context);
    
    //! Shape
    UIBezierPath *shape2 = [UIBezierPath bezierPath];
    [shape2 moveToPoint:CGPointMake(1, 1.5)];
    [shape2 addLineToPoint:CGPointMake(31, 1.5)];
    [shape2 addCurveToPoint:CGPointMake(32, 0.75) controlPoint1:CGPointMake(31.55, 1.5) controlPoint2:CGPointMake(32, 1.16)];
    [shape2 addCurveToPoint:CGPointMake(31, 0) controlPoint1:CGPointMake(32, 0.34) controlPoint2:CGPointMake(31.55, 0)];
    [shape2 addLineToPoint:CGPointMake(1, 0)];
    [shape2 addCurveToPoint:CGPointMake(0, 0.75) controlPoint1:CGPointMake(0.45, 0) controlPoint2:CGPointMake(0, 0.34)];
    [shape2 addCurveToPoint:CGPointMake(1, 1.5) controlPoint1:CGPointMake(0, 1.16) controlPoint2:CGPointMake(0.45, 1.5)];
    [shape2 addLineToPoint:CGPointMake(1, 1.5)];
    [shape2 closePath];
    [shape2 moveToPoint:CGPointMake(1, 1.5)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 3.67, 19);
    shape2.usesEvenOddFillRule = YES;
    [[LTLThemeManager sharedManager].themeColor setFill];
    [shape2 fill];
    CGContextRestoreGState(context);
    
    //! Shape
    UIBezierPath *shape3 = [UIBezierPath bezierPath];
    [shape3 moveToPoint:CGPointMake(1, 2)];
    [shape3 addLineToPoint:CGPointMake(31, 2)];
    [shape3 addCurveToPoint:CGPointMake(32, 1) controlPoint1:CGPointMake(31.55, 2) controlPoint2:CGPointMake(32, 1.55)];
    [shape3 addCurveToPoint:CGPointMake(31, 0) controlPoint1:CGPointMake(32, 0.45) controlPoint2:CGPointMake(31.55, 0)];
    [shape3 addLineToPoint:CGPointMake(1, 0)];
    [shape3 addCurveToPoint:CGPointMake(0, 1) controlPoint1:CGPointMake(0.45, 0) controlPoint2:CGPointMake(0, 0.45)];
    [shape3 addCurveToPoint:CGPointMake(1, 2) controlPoint1:CGPointMake(0, 1.55) controlPoint2:CGPointMake(0.45, 2)];
    [shape3 addLineToPoint:CGPointMake(1, 2)];
    [shape3 closePath];
    [shape3 moveToPoint:CGPointMake(1, 2)];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 3.67, 30);
    shape3.usesEvenOddFillRule = YES;
    [[LTLThemeManager sharedManager].themeColor setFill];
    [shape3 fill];
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
}


#pragma mark - Canvas Images

//! Page 1

+(UIImage *) imageOfArtboard
{
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(39, 39), NO, 0);
    [LTLSetMore drawArtboard];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *) imageOfArtboardWithSize:(CGSize)size resizing:(LTLSetMoreResizingBehavior)resizing
{
    UIImage *image = nil;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [LTLSetMore drawArtboardWithFrame:CGRectMake(0, 0, size.width, size.height) resizing:resizing];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - Resizing Behavior

CGRect LTLSetMoreResizingBehaviorApply(LTLSetMoreResizingBehavior behavior, CGRect rect, CGRect target)
{
    if (CGRectEqualToRect(rect, target) || CGRectEqualToRect(target, CGRectZero))
    {
        return rect;
    }
    
    CGSize scales = CGSizeZero;
    scales.width = ABS(target.size.width / rect.size.width);
    scales.height = ABS(target.size.height / rect.size.height);
    
    switch (behavior)
    {
        case LTLSetMoreResizingBehaviorAspectFit:
        {
            scales.width = MIN(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case LTLSetMoreResizingBehaviorAspectFill:
        {
            scales.width = MAX(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case LTLSetMoreResizingBehaviorStretch:
            break;
        
        case LTLSetMoreResizingBehaviorCenter:
        {
            scales.width = 1;
            scales.height = 1;
            break;
        }
    }
    
    CGRect result = CGRectStandardize(rect);
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    result.origin.x = target.origin.x + (target.size.width - result.size.width) / 2;
    result.origin.y = target.origin.y + (target.size.height - result.size.height) / 2;
    return result;
}


@end
