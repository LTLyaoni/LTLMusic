//
//  iCarousel.h
//
//  Version 1.8.2
//
//  Created by Nick Lockwood on 01/04/2011.
//  Copyright 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/iCarousel
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wreserved-id-macro"
#pragma clang diagnostic ignored "-Wobjc-missing-property-synthesis"


#import <Availability.h>
#undef weak_delegate
#undef __weak_delegate
#if __has_feature(objc_arc) && __has_feature(objc_arc_weak) && \
(!(defined __MAC_OS_X_VERSION_MIN_REQUIRED) || \
__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_8)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif


#import <QuartzCore/QuartzCore.h>
#if defined USING_CHAMELEON || defined __IPHONE_OS_VERSION_MAX_ALLOWED
#define ICAROUSEL_IOS
#else
#define ICAROUSEL_MACOS
#endif


#ifdef ICAROUSEL_IOS
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
typedef NSView UIView;
#endif


typedef NS_ENUM(NSInteger, iCarouselType)
{
    iCarouselTypeLinear = 0,             ///平铺，不循环
    iCarouselTypeRotary,                 ///外环，层叠
    iCarouselTypeInvertedRotary,         ///内环，层叠
    iCarouselTypeCylinder,               ///外环，拼接
    iCarouselTypeInvertedCylinder,       ///内环，拼接
    iCarouselTypeWheel,                  ///车轮，扇形，影响比较大。
    iCarouselTypeInvertedWheel,          ///车轮，扇形，影响比较大。
    iCarouselTypeCoverFlow,              ///翻页 不循环
    iCarouselTypeCoverFlow2,             ///翻页2，不循环
    iCarouselTypeTimeMachine,            ///向上堆叠，不循环
    iCarouselTypeInvertedTimeMachine,    ///反堆叠，不循环
    iCarouselTypeCustom
};


typedef NS_ENUM(NSInteger, iCarouselOption)
{
    iCarouselOptionWrap = 0,
    iCarouselOptionShowBackfaces,
    iCarouselOptionOffsetMultiplier,
    iCarouselOptionVisibleItems,
    iCarouselOptionCount,
    iCarouselOptionArc,
    iCarouselOptionAngle,
    iCarouselOptionRadius,
    iCarouselOptionTilt,
    iCarouselOptionSpacing,
    iCarouselOptionFadeMin,
    iCarouselOptionFadeMax,
    iCarouselOptionFadeRange,
    iCarouselOptionFadeMinAlpha
};


NS_ASSUME_NONNULL_BEGIN

@protocol iCarouselDataSource, iCarouselDelegate;

@interface iCarousel : UIView
///数据源
@property (nonatomic, weak_delegate) IBOutlet __nullable id<iCarouselDataSource> dataSource;
///代理
@property (nonatomic, weak_delegate) IBOutlet __nullable id<iCarouselDelegate> delegate;
///
@property (nonatomic, assign) iCarouselType type;
@property (nonatomic, assign) CGFloat perspective;
@property (nonatomic, assign) CGFloat decelerationRate;
@property (nonatomic, assign) CGFloat scrollSpeed;
@property (nonatomic, assign) CGFloat bounceDistance;
///是否可滚动
@property (nonatomic, assign, getter = isScrollEnabled) BOOL scrollEnabled;
///是否支持翻页
@property (nonatomic, assign, getter = isPagingEnabled) BOOL pagingEnabled;
///横竖屏
@property (nonatomic, assign, getter = isVertical) BOOL vertical;
///是否轮播
@property (nonatomic, readonly, getter = isWrapEnabled) BOOL wrapEnabled;
@property (nonatomic, assign) BOOL bounces;
////偏移量
@property (nonatomic, assign) CGFloat scrollOffset;
@property (nonatomic, readonly) CGFloat offsetMultiplier;
@property (nonatomic, assign) CGSize contentOffset;
@property (nonatomic, assign) CGSize viewpointOffset;
@property (nonatomic, readonly) NSInteger numberOfItems;
@property (nonatomic, readonly) NSInteger numberOfPlaceholders;
///当前下标
@property (nonatomic, assign) NSInteger currentItemIndex;
///当前ItemView
@property (nonatomic, strong, readonly) UIView * __nullable currentItemView;
@property (nonatomic, strong, readonly) NSArray *indexesForVisibleItems;
@property (nonatomic, readonly) NSInteger numberOfVisibleItems;
@property (nonatomic, strong, readonly) NSArray *visibleItemViews;
@property (nonatomic, readonly) CGFloat itemWidth;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, readonly) CGFloat toggle;
@property (nonatomic, assign) CGFloat autoscroll;
@property (nonatomic, assign) BOOL stopAtItemBoundary;
@property (nonatomic, assign) BOOL scrollToItemBoundary;
@property (nonatomic, assign) BOOL ignorePerpendicularSwipes;
@property (nonatomic, assign) BOOL centerItemWhenSelected;
@property (nonatomic, readonly, getter = isDragging) BOOL dragging;
@property (nonatomic, readonly, getter = isDecelerating) BOOL decelerating;
@property (nonatomic, readonly, getter = isScrolling) BOOL scrolling;

- (void)scrollByOffset:(CGFloat)offset duration:(NSTimeInterval)duration;
- (void)scrollToOffset:(CGFloat)offset duration:(NSTimeInterval)duration;
- (void)scrollByNumberOfItems:(NSInteger)itemCount duration:(NSTimeInterval)duration;
- (void)scrollToItemAtIndex:(NSInteger)index duration:(NSTimeInterval)duration;
- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated;

- (nullable UIView *)itemViewAtIndex:(NSInteger)index;
- (NSInteger)indexOfItemView:(UIView *)view;
- (NSInteger)indexOfItemViewOrSubview:(UIView *)view;
- (CGFloat)offsetForItemAtIndex:(NSInteger)index;
- (nullable UIView *)itemViewAtPoint:(CGPoint)point;

- (void)removeItemAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)insertItemAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)reloadItemAtIndex:(NSInteger)index animated:(BOOL)animated;

- (void)reloadData;

@end


@protocol iCarouselDataSource <NSObject>

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view;

@optional

- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(nullable UIView *)view;

@end


@protocol iCarouselDelegate <NSObject>
@optional

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel;
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel;
- (void)carouselDidScroll:(iCarousel *)carousel;
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel;
- (void)carouselWillBeginDragging:(iCarousel *)carousel;
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate;
- (void)carouselWillBeginDecelerating:(iCarousel *)carousel;
- (void)carouselDidEndDecelerating:(iCarousel *)carousel;

- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index;
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index;

- (CGFloat)carouselItemWidth:(iCarousel *)carousel;
- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform;
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop

