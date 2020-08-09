//
//  UIView+TransitonColor.h
//  test
//
//  Created by Gamin on 2019/5/15.
//  Copyright © 2019 www.hidui.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TransitonColor)
//添加渐变色
- (void)addTransitionColor:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)addTransitionColorLeftToRight:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)addTransitionColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
