//
//  LTLskin.m
//  音乐播放器
//
//  Created by 李泰良 on 16/12/16.
//  Copyright © 2016 LTL. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;
#import "LTLskin.h"



@implementation LTLskin


#pragma mark - Canvas Drawings

//! Page 1

+(void) drawSkin
{
    [LTLskin drawSkinWithFrame:CGRectMake(0, 0, 160, 160) resizing:LTLskinResizingBehaviorAspectFit];
}

+(void) drawSkinWithFrame:(CGRect)frame resizing:(LTLskinResizingBehavior)resizing
{
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize To Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = LTLskinResizingBehaviorApply(resizing, CGRectMake(0, 0, 160, 160), frame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGSize resizedScale = CGSizeMake(resizedFrame.size.width / 160, resizedFrame.size.height / 160);
    CGContextScaleCTM(context, resizedScale.width, resizedScale.height);
    
    //! Rectangle
    UIBezierPath *rectangle = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 138, 138) cornerRadius:26];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 11, 11);
    CGContextSaveGState(context);
    rectangle.lineWidth = 10;
    CGContextBeginPath(context);
    CGContextAddPath(context, rectangle.CGPath);
    CGContextEOClip(context);
    [[LTLThemeManager sharedManager].themeColor setStroke];
    [rectangle stroke];
    CGContextRestoreGState(context);
    CGContextRestoreGState(context);
    
    //! Page 1
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 37, 35);
        
        //! Group 3
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0, 0.56);
            
            //! Fill 1
            UIBezierPath *fill1 = [UIBezierPath bezierPath];
            [fill1 moveToPoint:CGPointMake(22.57, 83.17)];
            [fill1 addCurveToPoint:CGPointMake(22.91, 83.2) controlPoint1:CGPointMake(22.58, 83.17) controlPoint2:CGPointMake(22.69, 83.2)];
            [fill1 addLineToPoint:CGPointMake(64.81, 83.2)];
            [fill1 addCurveToPoint:CGPointMake(65.17, 83.15) controlPoint1:CGPointMake(65.04, 83.2) controlPoint2:CGPointMake(65.15, 83.17)];
            [fill1 addCurveToPoint:CGPointMake(65.38, 81.04) controlPoint1:CGPointMake(65.38, 82.9) controlPoint2:CGPointMake(65.38, 81.55)];
            [fill1 addLineToPoint:CGPointMake(64.13, 25.66)];
            [fill1 addCurveToPoint:CGPointMake(64.83, 24.3) controlPoint1:CGPointMake(64.12, 25.12) controlPoint2:CGPointMake(64.38, 24.61)];
            [fill1 addCurveToPoint:CGPointMake(66.35, 24.16) controlPoint1:CGPointMake(65.28, 24) controlPoint2:CGPointMake(65.85, 23.95)];
            [fill1 addLineToPoint:CGPointMake(73.87, 27.41)];
            [fill1 addCurveToPoint:CGPointMake(74.19, 27.6) controlPoint1:CGPointMake(73.98, 27.46) controlPoint2:CGPointMake(74.09, 27.53)];
            [fill1 addLineToPoint:CGPointMake(84.54, 16.91)];
            [fill1 addLineToPoint:CGPointMake(74.34, 5.14)];
            [fill1 addCurveToPoint:CGPointMake(74.34, 5.14) controlPoint1:CGPointMake(74.34, 5.14) controlPoint2:CGPointMake(74.34, 5.14)];
            [fill1 addCurveToPoint:CGPointMake(62, 3.18) controlPoint1:CGPointMake(74.32, 5.14) controlPoint2:CGPointMake(71.79, 3.18)];
            [fill1 addLineToPoint:CGPointMake(57.28, 3.18)];
            [fill1 addCurveToPoint:CGPointMake(44.1, 15.23) controlPoint1:CGPointMake(52.67, 14.34) controlPoint2:CGPointMake(46.07, 15.23)];
            [fill1 addCurveToPoint:CGPointMake(43.44, 15.2) controlPoint1:CGPointMake(43.8, 15.23) controlPoint2:CGPointMake(43.58, 15.21)];
            [fill1 addCurveToPoint:CGPointMake(30.52, 3.18) controlPoint1:CGPointMake(37.05, 15.1) controlPoint2:CGPointMake(32.07, 6.27)];
            [fill1 addLineToPoint:CGPointMake(25.72, 3.18)];
            [fill1 addCurveToPoint:CGPointMake(13.29, 5.24) controlPoint1:CGPointMake(15.75, 3.18) controlPoint2:CGPointMake(13.31, 5.22)];
            [fill1 addLineToPoint:CGPointMake(3.28, 16.8)];
            [fill1 addCurveToPoint:CGPointMake(4.62, 18.34) controlPoint1:CGPointMake(3.55, 17.27) controlPoint2:CGPointMake(4.31, 18.03)];
            [fill1 addLineToPoint:CGPointMake(12.1, 26.18)];
            [fill1 addCurveToPoint:CGPointMake(13.65, 27.52) controlPoint1:CGPointMake(12.41, 26.49) controlPoint2:CGPointMake(13.19, 27.27)];
            [fill1 addCurveToPoint:CGPointMake(13.86, 27.41) controlPoint1:CGPointMake(13.72, 27.48) controlPoint2:CGPointMake(13.78, 27.44)];
            [fill1 addLineToPoint:CGPointMake(21.37, 24.16)];
            [fill1 addCurveToPoint:CGPointMake(22.89, 24.3) controlPoint1:CGPointMake(21.87, 23.95) controlPoint2:CGPointMake(22.44, 24)];
            [fill1 addCurveToPoint:CGPointMake(23.59, 25.66) controlPoint1:CGPointMake(23.34, 24.61) controlPoint2:CGPointMake(23.6, 25.12)];
            [fill1 addLineToPoint:CGPointMake(22.34, 81.08)];
            [fill1 addCurveToPoint:CGPointMake(22.57, 83.17) controlPoint1:CGPointMake(22.35, 81.55) controlPoint2:CGPointMake(22.35, 82.9)];
            [fill1 addLineToPoint:CGPointMake(22.57, 83.17)];
            [fill1 closePath];
            [fill1 moveToPoint:CGPointMake(64.81, 86.38)];
            [fill1 addLineToPoint:CGPointMake(22.91, 86.38)];
            [fill1 addCurveToPoint:CGPointMake(19.17, 81.04) controlPoint1:CGPointMake(19.17, 86.38) controlPoint2:CGPointMake(19.17, 82.77)];
            [fill1 addLineToPoint:CGPointMake(20.36, 28.06)];
            [fill1 addLineToPoint:CGPointMake(15.34, 30.23)];
            [fill1 addCurveToPoint:CGPointMake(13.77, 30.76) controlPoint1:CGPointMake(14.88, 30.58) controlPoint2:CGPointMake(14.35, 30.76)];
            [fill1 addCurveToPoint:CGPointMake(9.84, 28.42) controlPoint1:CGPointMake(12.19, 30.76) controlPoint2:CGPointMake(10.83, 29.41)];
            [fill1 addLineToPoint:CGPointMake(2.36, 20.58)];
            [fill1 addCurveToPoint:CGPointMake(0.8, 14.83) controlPoint1:CGPointMake(1.27, 19.49) controlPoint2:CGPointMake(-1.3, 16.92)];
            [fill1 addLineToPoint:CGPointMake(10.98, 3.06)];
            [fill1 addCurveToPoint:CGPointMake(25.72, 0) controlPoint1:CGPointMake(11.47, 2.52) controlPoint2:CGPointMake(14.36, 0)];
            [fill1 addLineToPoint:CGPointMake(31.52, 0)];
            [fill1 addCurveToPoint:CGPointMake(32.97, 0.93) controlPoint1:CGPointMake(32.14, 0) controlPoint2:CGPointMake(32.71, 0.36)];
            [fill1 addCurveToPoint:CGPointMake(43.55, 12.02) controlPoint1:CGPointMake(34.38, 4.01) controlPoint2:CGPointMake(39.03, 12.02)];
            [fill1 addCurveToPoint:CGPointMake(43.82, 12.04) controlPoint1:CGPointMake(43.64, 12.02) controlPoint2:CGPointMake(43.73, 12.03)];
            [fill1 addCurveToPoint:CGPointMake(44.1, 12.05) controlPoint1:CGPointMake(43.83, 12.04) controlPoint2:CGPointMake(43.94, 12.05)];
            [fill1 addCurveToPoint:CGPointMake(54.72, 1.02) controlPoint1:CGPointMake(45.61, 12.05) controlPoint2:CGPointMake(50.82, 11.26)];
            [fill1 addCurveToPoint:CGPointMake(56.2, 0) controlPoint1:CGPointMake(54.95, 0.41) controlPoint2:CGPointMake(55.54, 0)];
            [fill1 addLineToPoint:CGPointMake(62, 0)];
            [fill1 addCurveToPoint:CGPointMake(76.71, 3.03) controlPoint1:CGPointMake(73.36, 0) controlPoint2:CGPointMake(76.25, 2.52)];
            [fill1 addLineToPoint:CGPointMake(87, 14.91)];
            [fill1 addCurveToPoint:CGPointMake(86.94, 19) controlPoint1:CGPointMake(88.51, 16.42) controlPoint2:CGPointMake(88.51, 17.43)];
            [fill1 addLineToPoint:CGPointMake(76.32, 29.98)];
            [fill1 addCurveToPoint:CGPointMake(74.21, 31.19) controlPoint1:CGPointMake(75.66, 30.64) controlPoint2:CGPointMake(75.11, 31.19)];
            [fill1 addCurveToPoint:CGPointMake(72.33, 30.21) controlPoint1:CGPointMake(73.41, 31.19) controlPoint2:CGPointMake(72.88, 30.75)];
            [fill1 addLineToPoint:CGPointMake(67.36, 28.06)];
            [fill1 addLineToPoint:CGPointMake(68.56, 81.01)];
            [fill1 addCurveToPoint:CGPointMake(64.81, 86.38) controlPoint1:CGPointMake(68.56, 82.77) controlPoint2:CGPointMake(68.56, 86.38)];
            [fill1 addLineToPoint:CGPointMake(64.81, 86.38)];
            [fill1 closePath];
            [fill1 moveToPoint:CGPointMake(64.81, 86.38)];
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, -0, 0.03);
            fill1.usesEvenOddFillRule = YES;
            [[LTLThemeManager sharedManager].themeColor setFill];
            [fill1 fill];
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
        }
        
        //! Fill 6
        UIBezierPath *fill6 = [UIBezierPath bezierPath];
        [fill6 moveToPoint:CGPointMake(3.42, 1.65)];
        [fill6 addCurveToPoint:CGPointMake(1.65, 2.53) controlPoint1:CGPointMake(2.34, 1.65) controlPoint2:CGPointMake(1.65, 2.17)];
        [fill6 addCurveToPoint:CGPointMake(3.42, 3.41) controlPoint1:CGPointMake(1.65, 2.89) controlPoint2:CGPointMake(2.34, 3.41)];
        [fill6 addCurveToPoint:CGPointMake(5.18, 2.53) controlPoint1:CGPointMake(4.49, 3.41) controlPoint2:CGPointMake(5.18, 2.89)];
        [fill6 addCurveToPoint:CGPointMake(3.42, 1.65) controlPoint1:CGPointMake(5.18, 2.17) controlPoint2:CGPointMake(4.49, 1.65)];
        [fill6 moveToPoint:CGPointMake(3.42, 5.06)];
        [fill6 addCurveToPoint:CGPointMake(0, 2.53) controlPoint1:CGPointMake(1.5, 5.06) controlPoint2:CGPointMake(0, 3.95)];
        [fill6 addCurveToPoint:CGPointMake(3.42, 0) controlPoint1:CGPointMake(0, 1.11) controlPoint2:CGPointMake(1.5, 0)];
        [fill6 addCurveToPoint:CGPointMake(6.83, 2.53) controlPoint1:CGPointMake(5.33, 0) controlPoint2:CGPointMake(6.83, 1.11)];
        [fill6 addCurveToPoint:CGPointMake(3.42, 5.06) controlPoint1:CGPointMake(6.83, 3.95) controlPoint2:CGPointMake(5.33, 5.06)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 33.84, 38.35);
        fill6.usesEvenOddFillRule = YES;
        [[LTLThemeManager sharedManager].themeColor setFill];
        [fill6 fill];
        CGContextRestoreGState(context);
        
        //! Fill 8
        UIBezierPath *fill8 = [UIBezierPath bezierPath];
        [fill8 moveToPoint:CGPointMake(0, 15.44)];
        [fill8 addLineToPoint:CGPointMake(1.65, 15.44)];
        [fill8 addLineToPoint:CGPointMake(1.65, 0)];
        [fill8 addLineToPoint:CGPointZero];
        [fill8 addLineToPoint:CGPointMake(0, 15.44)];
        [fill8 closePath];
        [fill8 moveToPoint:CGPointMake(0, 15.44)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 39.02, 25.44);
        fill8.usesEvenOddFillRule = YES;
        [[LTLThemeManager sharedManager].themeColor setFill];
        [fill8 fill];
        CGContextRestoreGState(context);
        
        //! Fill 10
        UIBezierPath *fill10 = [UIBezierPath bezierPath];
        [fill10 moveToPoint:CGPointMake(3.42, 1.65)];
        [fill10 addCurveToPoint:CGPointMake(1.65, 2.53) controlPoint1:CGPointMake(2.34, 1.65) controlPoint2:CGPointMake(1.65, 2.17)];
        [fill10 addCurveToPoint:CGPointMake(3.42, 3.41) controlPoint1:CGPointMake(1.65, 2.89) controlPoint2:CGPointMake(2.34, 3.41)];
        [fill10 addCurveToPoint:CGPointMake(5.18, 2.53) controlPoint1:CGPointMake(4.49, 3.41) controlPoint2:CGPointMake(5.18, 2.89)];
        [fill10 addCurveToPoint:CGPointMake(3.42, 1.65) controlPoint1:CGPointMake(5.18, 2.17) controlPoint2:CGPointMake(4.49, 1.65)];
        [fill10 moveToPoint:CGPointMake(3.42, 5.06)];
        [fill10 addCurveToPoint:CGPointMake(0, 2.53) controlPoint1:CGPointMake(1.5, 5.06) controlPoint2:CGPointMake(0, 3.95)];
        [fill10 addCurveToPoint:CGPointMake(3.42, 0) controlPoint1:CGPointMake(0, 1.11) controlPoint2:CGPointMake(1.5, 0)];
        [fill10 addCurveToPoint:CGPointMake(6.83, 2.53) controlPoint1:CGPointMake(5.33, 0) controlPoint2:CGPointMake(6.83, 1.11)];
        [fill10 addCurveToPoint:CGPointMake(3.42, 5.06) controlPoint1:CGPointMake(6.83, 3.95) controlPoint2:CGPointMake(5.33, 5.06)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 46.13, 43.62);
        fill10.usesEvenOddFillRule = YES;
        [[LTLThemeManager sharedManager].themeColor setFill];
        [fill10 fill];
        CGContextRestoreGState(context);
        
        //! Fill 11
        UIBezierPath *fill11 = [UIBezierPath bezierPath];
        [fill11 moveToPoint:CGPointMake(0.83, 17.09)];
        [fill11 addCurveToPoint:CGPointMake(0, 16.26) controlPoint1:CGPointMake(0.37, 17.09) controlPoint2:CGPointMake(0, 16.72)];
        [fill11 addLineToPoint:CGPointMake(0, 0.83)];
        [fill11 addCurveToPoint:CGPointMake(0.83, 0) controlPoint1:CGPointMake(0, 0.37) controlPoint2:CGPointMake(0.37, 0)];
        [fill11 addCurveToPoint:CGPointMake(1.65, 0.83) controlPoint1:CGPointMake(1.28, 0) controlPoint2:CGPointMake(1.65, 0.37)];
        [fill11 addLineToPoint:CGPointMake(1.65, 16.26)];
        [fill11 addCurveToPoint:CGPointMake(0.83, 17.09) controlPoint1:CGPointMake(1.65, 16.72) controlPoint2:CGPointMake(1.28, 17.09)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 51.31, 29.88);
        fill11.usesEvenOddFillRule = YES;
        [[LTLThemeManager sharedManager].themeColor setFill];
        [fill11 fill];
        CGContextRestoreGState(context);
        
        //! Fill 12
        UIBezierPath *fill12 = [UIBezierPath bezierPath];
        [fill12 moveToPoint:CGPointMake(13.11, 6.92)];
        [fill12 addCurveToPoint:CGPointMake(12.79, 6.85) controlPoint1:CGPointMake(13.01, 6.92) controlPoint2:CGPointMake(12.89, 6.9)];
        [fill12 addLineToPoint:CGPointMake(0.5, 1.59)];
        [fill12 addCurveToPoint:CGPointMake(0.07, 0.5) controlPoint1:CGPointMake(0.08, 1.41) controlPoint2:CGPointMake(-0.11, 0.92)];
        [fill12 addCurveToPoint:CGPointMake(1.15, 0.07) controlPoint1:CGPointMake(0.25, 0.08) controlPoint2:CGPointMake(0.73, -0.11)];
        [fill12 addLineToPoint:CGPointMake(13.44, 5.33)];
        [fill12 addCurveToPoint:CGPointMake(13.87, 6.42) controlPoint1:CGPointMake(13.86, 5.51) controlPoint2:CGPointMake(14.05, 6)];
        [fill12 addCurveToPoint:CGPointMake(13.11, 6.92) controlPoint1:CGPointMake(13.74, 6.73) controlPoint2:CGPointMake(13.43, 6.92)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 39.02, 24.62);
        fill12.usesEvenOddFillRule = YES;
        [[LTLThemeManager sharedManager].themeColor setFill];
        [fill12 fill];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}


#pragma mark - Canvas Images

//! Page 1

+(UIImage *) imageOfSkin
{
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), NO, 0);
    [LTLskin drawSkin];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *) imageOfSkinWithSize:(CGSize)size resizing:(LTLskinResizingBehavior)resizing
{
    UIImage *image = nil;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [LTLskin drawSkinWithFrame:CGRectMake(0, 0, size.width, size.height) resizing:resizing];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - Resizing Behavior

CGRect LTLskinResizingBehaviorApply(LTLskinResizingBehavior behavior, CGRect rect, CGRect target)
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
        case LTLskinResizingBehaviorAspectFit:
        {
            scales.width = MIN(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case LTLskinResizingBehaviorAspectFill:
        {
            scales.width = MAX(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case LTLskinResizingBehaviorStretch:
            break;
        
        case LTLskinResizingBehaviorCenter:
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
