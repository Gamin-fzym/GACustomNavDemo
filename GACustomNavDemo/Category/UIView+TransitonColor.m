//
//  UIView+TransitonColor.m
//  test
//
//  Created by Gamin on 2019/5/15.
//  Copyright © 2019 www.hidui.com. All rights reserved.
//

#import "UIView+TransitonColor.h"

@implementation UIView (TransitonColor)
//左右渐变
- (void)addTransitionColorLeftToRight:(UIColor *)startColor endColor:(UIColor *)endColor {
    [self addTransitionColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}

//斜渐变
- (void)addTransitionColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    [self addTransitionColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
}

- (void)addTransitionColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0, @1];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
