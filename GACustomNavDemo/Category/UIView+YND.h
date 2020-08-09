//
//  UIView+YND.h
//
//  Created by xuxin on 2018/1/26.
//  Copyright © 2018年 www.hidui.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YND)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign, readonly) CGFloat halfHeight;
@property (nonatomic, assign, readonly) CGFloat halfWidth;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
- (void)setCornerRadius:(CGFloat)cornerRadius rounding:(UIRectCorner)rounding;
/** 边框颜色 */
@property (nonatomic, strong) IBInspectable UIColor * borderColor;
/** 边框宽度 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/** 最大 X */
@property (nonatomic, assign) CGFloat maxX;
/** 最大 Y */
@property (nonatomic, assign) CGFloat maxY;
/// 同时设置 maxX 和 maxY
@property (nonatomic, assign) CGPoint maxOrigin;

/// 取自己的子控件的最大的Y值
- (CGFloat)getLastSubViewY;

- (void)setBorderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor;
- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor;

+ (instancetype)viewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame;

///  创建view
///  由子类实现
+ (instancetype)creatView;
///  从xib中加载和类名一样的xib
+ (instancetype)creatViewFromNib;
///  从xib中加载view
///  @param aName xib名字
///  @param index 在xib数组中的索引
+ (instancetype)creatViewFromNibName:(NSString *)aName atIndex:(NSInteger)index;

///  Rect{0, 64, screenW, screenH - 64}
extern CGRect defaultRect();

///  找到view的控制器：返回view所加载在的控制器
- (UIViewController *)sl_viewController;
///  找到view的控制器：返回view所加载在的导航控制器
- (UINavigationController *)navigationController;

///  移除子控件
- (void)removeAllSubviews;

///  计算相对frame
- (CGRect)relativeFrameForScreen;

///  递归遍历所有的子控件，通过block将subview传出来
- (void)enumerateSubviewsWithHandlerBlock:(void(^)(UIView *const x))block;
@end


@interface UILabel (YND)

+ (instancetype)labelWithText:(NSString *)text font:(CGFloat)fontSize textColor:(UIColor *)color frame:(CGRect)frame;

@end


@interface UIImageView (YND)
+ (instancetype)imageViewWithUrl:(NSURL *)url frame:(CGRect)frame;
+ (instancetype)imageViewWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder frame:(CGRect)frame;
+ (instancetype)imageViewWithImage:(UIImage *)image frame:(CGRect)frame;
@end

@interface UIScrollView (YND)
+ (instancetype)defaultScrollView;
+ (instancetype)scrollViewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame;
@end
