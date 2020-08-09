//
//  UIView+YND.m
//
//  Created by xuxin on 2018/1/26.
//  Copyright © 2018年 www.hidui.com. All rights reserved.
//

#import "UIView+YND.h"
#import <objc/runtime.h>
#import "CommonHeader.h"
@implementation UIView (YND)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)halfWidth {
    return CGRectGetWidth(self.frame) * 0.5;
}

- (CGFloat)halfHeight {
    return CGRectGetHeight(self.frame) * 0.5;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}


- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setCornerRadius:(CGFloat)cornerRadius rounding:(UIRectCorner)rounding {
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rounding cornerRadii:Size(cornerRadius, cornerRadius)];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor {
    self.borderWidth = bWidth;
    self.borderColor = bColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor {
    self.cornerRadius = cornerRadius;
    [self setBorderWidth:bWidth borderColor:bColor];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (void)setMaxX:(CGFloat)maxX {
    self.x = maxX - CGRectGetWidth(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setMaxY:(CGFloat)maxY {
    self.y = maxY - CGRectGetHeight(self.frame);
}

- (void)setMaxOrigin:(CGPoint)maxOrigin {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(maxOrigin.x - CGRectGetWidth(self.frame), maxOrigin.y - CGRectGetHeight(self.frame));
    self.frame = frame;
}

- (CGPoint)maxOrigin {
    return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
}

- (CGFloat)getLastSubViewY {
    return self.subviews.lastObject.maxY;
}

+ (instancetype)viewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame {
    UIView * view = [[self alloc] initWithFrame:frame];
    if (!bgColor) {
        view.backgroundColor = [UIColor clearColor];
    } else {
        view.backgroundColor = bgColor;
    }
    return view;
}
+ (instancetype)creatView { return nil; }
///  从xib中加载和类名一样的xib
+ (instancetype)creatViewFromNib {
    return [self creatViewFromNibName:NSStringFromClass([self class]) atIndex:0];
}

+ (instancetype)creatViewFromNibName:(NSString *)aName atIndex:(NSInteger)index {
    //    return _creatViewFromNibNameWithCache(aName, index);
    return [[[NSBundle mainBundle] loadNibNamed:aName owner:nil options:nil] objectAtIndex:index];
}

CGRect defaultRect() {
    return CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64);
}
///  找到view的控制器：返回view所加载在的控制器
- (UIViewController *)sl_viewController {
    for (UIView * superView = [self superview]; superView; superView = superView.superview) {
        UIResponder *nextResponder = [superView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (UINavigationController *)navigationController {
    return self.sl_viewController.navigationController;
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CGRect)relativeFrameForScreen
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    return [self convertRect: self.bounds toView:window];
}

- (void)_enumerateSubviewsInView:(UIView *)superView handlerBlock:(void (^)(UIView *const))block {
    if (!superView.subviews.count) return;
    for (UIView * subView in superView.subviews) {
        BLOCK_SAFE_RUN(block, subView);
        [self _enumerateSubviewsInView:subView handlerBlock:block];
    }
}

- (void)enumerateSubviewsWithHandlerBlock:(void (^)(UIView *const))block {
    [self _enumerateSubviewsInView:self handlerBlock:block];
}

@end


#pragma mark - UILabel (Extension)
@implementation UILabel (YND)

+ (instancetype)labelWithText:(NSString *)text font:(CGFloat)fontSize textColor:(UIColor *)color frame:(CGRect)frame {
    UILabel * label = [[self alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    if (text) label.text = text;
    if (color) label.textColor = color;
    return label;
}
@end


#pragma mark - UIImageView
@implementation UIImageView (YND)

+ (instancetype)imageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    //    NSAssert(image != nil, @"图片不能为空");
    UIImageView * imageView = [[self alloc] initWithFrame:frame];
    [imageView setImage:image];
    return imageView;
}

+ (instancetype)imageViewWithUrl:(NSURL *)url frame:(CGRect)frame {
    
    return [self imageViewWithUrl:url placeHolder:nil frame:frame];
}

+ (instancetype)imageViewWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder frame:(CGRect)frame {
    
    UIImageView * imageView = [[self alloc] initWithFrame:frame];
  //  [imageView sd_setImageWithURL:url placeholderImage:placeHolder];
    return imageView;
}


@end

#pragma mark - UIScrollView
@implementation UIScrollView (YND)

+ (instancetype)defaultScrollView {
    return [self scrollViewWithBgColor:nil frame:Rect(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
}

+ (instancetype)scrollViewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame {
    UIScrollView * scrollView = [[self alloc] initWithFrame:frame];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    if (bgColor) {
        scrollView.backgroundColor = bgColor;
    } else {
        scrollView.backgroundColor = [UIColor clearColor];
    }
    return scrollView;
}

@end
