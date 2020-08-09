//
//  RMNavigationBar.m
//  RideMoto
//
//  Created by apple on 2016/12/8.
//  Copyright © 2016年 TGF. All rights reserved.
//

#import <objc/runtime.h>
#import "RMNavigationBar.h"
#import "CommonHeader.h"

/// 返回按钮图片
static NSString * BackButtonImageName = @"导航返回";
///  标题文字大小
static CGFloat    TitleFont           = 18;
///  按钮文字大小
static CGFloat    ButtonFont          = 15;
typedef void (^ButtonClick)(void);

@interface RMNavigationBar ()

@property (nonatomic,   copy) ButtonClick backBlock;
@property (nonatomic,   copy) ButtonClick actionBlock;
@end

@implementation RMNavigationBar {
//    UIView * _diveder;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIInterfaceOrientation sataus=[UIApplication sharedApplication].statusBarOrientation;
        if (sataus == UIInterfaceOrientationLandscapeRight) {
            self.size = Size(SCREENWIDTH, NAVBARHEIGHT);
        }else{
            self.size = Size(SCREENHEIGHT, NAVBARHEIGHT);
        }
        [self addTransitionColor:HexColor(@"#2F4DA2") endColor:HexColor(@"#1E7FD7")];
        // 分隔线
        UIView * diveder = [UIView new];
        diveder.frame = Rect(0, NAVBARHEIGHT - 0.5, SCREENWIDTH, 0.5);
        diveder.backgroundColor = HexColorInt32_t(307859);
        [self addSubview:diveder];
        [self bringSubviewToFront:diveder];
        _diveder = diveder;
    }
    return self;
}

- (void)removeDivider {
    [_diveder removeFromSuperview];
}

- (instancetype)initWithObject:(id)obj rights:(NSArray *)rights rightAction:(void (^)(NSInteger))action backAction:(void (^)(void))backAction {
    
    if (self = [super init]) {
        CGFloat centerY = 20 + (NAVBARHEIGHT - 20) / 2;
        // 标题
        UIView * centerView = nil;
        if ([obj isKindOfClass:NSString.class]) {
            
            UILabel * label =  [UILabel labelWithText:obj font:TitleFont textColor:ThemeTitleColor frame:Rect(45, NAVBARHEIGHT - 44, SCREENWIDTH - 90, 42)];
            label.font = [UIFont boldSystemFontOfSize:TitleFont];
            [self addSubview:label];
            _titleLabel = (UILabel *)label;
            label.textAlignment = NSTextAlignmentCenter;
            label.lineBreakMode = NSLineBreakByTruncatingMiddle;
            centerView = label;
        } else if ([obj isKindOfClass:UIView.class]) {
            UIView * objView = obj;
            [self addSubview:objView];
            if (objView.height > 44) {
                objView.height = 44;
            }
            if (objView.width > SCREENWIDTH - 120) {
                objView.width = SCREENWIDTH - 120;
            }
            objView.center = Point(SCREENWIDTH/2.0f, centerY);
            centerView = objView;
            _customView = objView;
        }
        
        // 如果实现了右边的事件，会创建右边的按钮
        if (action) {
            CGFloat maxX = SCREENWIDTH - 7;
            NSMutableArray * btns = @[].mutableCopy;
            for (int i = 0; i < rights.count; i++) {
                NSString * right = rights[i];
                UIButton * rightBtn = nil;
                UIImage * image = [UIImage rm_imageNamed:right];
                if (image) {
                    if (i == 0) maxX -= 3;
                    rightBtn = [UIButton buttonWithTitle:nil titleColor:[UIColor whiteColor] backgroundColor:nil font:0 image:right frame:Rect(0, HeightStatusBar, 44, 44)];
                    [self addSubview:rightBtn];
                    rightBtn.maxX = maxX;
                    maxX = rightBtn.x;
                } else {
                    if (i == 0) maxX -= 8;
                    if ([right length]) {
                        CGSize size = [NSString getStringRect:right fontSize:ButtonFont width:300];
                        rightBtn = [UIButton buttonWithTitle:right titleColor:[UIColor whiteColor] backgroundColor:nil font:ButtonFont image:nil frame:Rect(0, HeightStatusBar, size.width, 44)];
                        [self addSubview:rightBtn];
                        rightBtn.maxX = maxX;
                        maxX = rightBtn.x - 7;
                    }
                }
                rightBtn.tag = i;
                [rightBtn addTarget:self action:@selector(rightBtnClick:)];
                self.rightBtnAction = action;
                if (rightBtn) [btns addObject:rightBtn];
            }
            if (btns.count == 1) {
                self.rightButton = [btns lastObject];
            } else {
                _rightButtons = [btns copy];
            }
        }
        
        // 如果实现了返回的事件，才创建返回按钮
        if (backAction) {
            UIButton * back = [UIButton buttonWithTitle:nil titleColor:nil backgroundColor:nil font:ButtonFont image:BackButtonImageName frame:Rect(0, HeightStatusBar, 44, 44)];
            [back addTarget:self action:@selector(backClick)];
     
            back.adjustsImageWhenHighlighted = NO;
            [self addSubview:back];
            self.backBlock = backAction;
            self.leftButton = back;
        }
        
    }
    return self;
}

#pragma mark - ButtonAction
- (void)btnClick {
    !self.actionBlock ? : self.actionBlock();
}

- (void)backClick {
    !self.backBlock ? : self.backBlock();
}

- (void)rightBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    BLOCK_SAFE_RUN(self.rightBtnAction, btn.selected);
}

- (void)setupToWhiteTheme {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = HexColorInt32_t(000000);
    self.rightButton.titleColor = HexColorInt32_t(333333);
    self.leftButton.image = [UIImage imageNamed:@"btn_back_gray"];
    [_diveder removeFromSuperview];
}

#pragma mark - 类方法
+ (instancetype)navWithTitle:(NSString *)title rightItem:(NSString *)rightItem rightAction:(void (^)(void))action {
    RMNavigationBar * nav = [[self alloc] initWithObject:title rights:rightItem.length ? @[rightItem] :nil rightAction:^(NSInteger index) {
        BLOCK_SAFE_RUN(action);
    } backAction:nil];
    return nav;
}

+ (instancetype)navWithTitle:(NSString *)title {
//    return [[self alloc] initWithObject:title right:nil rightAction:nil backAction:nil];
    RMNavigationBar * nav = [[self alloc] initWithObject:title rights:nil rightAction:nil backAction:nil];
    return nav;
}

+ (instancetype)navWithTitle:(NSString *)title backAction:(void (^)(void))backAction {
//    return [[self alloc] initWithObject:title right:nil rightAction:nil backAction:backAction];
    RMNavigationBar * nav = [[self alloc] initWithObject:title rights:nil rightAction:nil backAction:backAction];
    return nav;
}

+ (instancetype)navWithTitle:(NSString *)title rightItem:(NSString *)rightItem rightAction:(void (^)(void))action backAction:(void (^)(void))backAction {
//    return [[self alloc] initWithObject:title right:rightItem rightAction:action backAction:backAction];
    RMNavigationBar * nav = [[self alloc] initWithObject:title rights:rightItem.length ? @[rightItem] :nil rightAction:^(NSInteger index) {
        BLOCK_SAFE_RUN(action);
    } backAction:backAction];
    return nav;
}

+ (instancetype)navWithCustomView:(UIView *)costomView rightItem:(NSString *)rightItem rightAction:(void (^)(void))action backAction:(void (^)(void))backAction {
//    return [[self alloc] initWithObject:costomView right:rightItem rightAction:action backAction:backAction];
    
    RMNavigationBar * nav = [[self alloc] initWithObject:costomView rights:rightItem.length ? @[rightItem] :nil rightAction:^(NSInteger index) {
        BLOCK_SAFE_RUN(action);
    } backAction:backAction];
    return nav;
}

+ (instancetype)navWithTitle:(NSString *)title rightItems:(NSArray<NSString *> *)rightItems rightAction:(void(^)(NSInteger index))action backAction:(void(^)(void))backAction {
    return [[self alloc] initWithObject:title rights:rightItems rightAction:action backAction:backAction];
}

//自定义左右按钮
+ (instancetype)navWithTitle:(NSString *)title
                     lefItem:(id)leftItem
                  leftAction:(void(^)(void))leftAction rightItem:(NSString *)rightItem rightAction:(void(^)(void))rightAction
{
    
    RMNavigationBar * nav = [[self alloc] initWithObject:title rights:rightItem.length ? @[rightItem] : nil rightAction:^(NSInteger index) {
        BLOCK_SAFE_RUN(rightAction);
    } backAction:leftAction];
    UIImage *img = nil;
    if ([leftItem isKindOfClass:[NSString class]]) {
        img = ImageWithName(leftItem);
    }else{
        img = leftItem;
    }
    if (img) {
        [nav.leftButton setImage:img forState:UIControlStateNormal];
    } else if (!img && [leftItem isKindOfClass:NSString.class]) {
        [nav.leftButton setImage:nil forState:UIControlStateNormal];
        [nav.leftButton setTitle:leftItem forState:UIControlStateNormal];
        [nav.leftButton sizeToFit];
        nav.leftButton.centerY = nav.titleLabel.centerY;
    }
    return nav;
}

+ (instancetype)navWithCustomView:(UIView *)customView
                            frame:(CGRect)frame
                       backAction:(void(^)(void))backAction
{
    RMNavigationBar *nav = [[RMNavigationBar alloc] init];
    if (customView) {
        CGFloat x = backAction ? frame.origin.x + 44 : frame.origin.x;
        customView.frame = Rect(x, frame.origin.y, frame.size.width, frame.size.height);
        [nav addSubview:customView];
    }
    // 如果实现了返回的事件，才创建返回按钮
    if (backAction) {
        nav.backBlock = backAction;
        UIButton * back = [UIButton buttonWithTitle:nil titleColor:nil backgroundColor:nil font:ButtonFont image:BackButtonImageName frame:Rect(0, HeightStatusBar, 44, 44)];
        [back addTarget:nav action:@selector(backClick)];
        back.adjustsImageWhenHighlighted = NO;
        [nav addSubview:back];
    }
    return nav;
}
@end


static const char NavgationBarkey = '\0';
@implementation UIViewController (NavigatiionBar)

- (void)setRm_navgationBar:(RMNavigationBar *)rm_navgationBar {
    
    if (self.rm_navgationBar != rm_navgationBar) {
        [self.rm_navgationBar removeFromSuperview];
        [self.view addSubview:rm_navgationBar];
        objc_setAssociatedObject(self, &NavgationBarkey, rm_navgationBar, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (RMNavigationBar *)rm_navgationBar {
    return objc_getAssociatedObject(self, &NavgationBarkey);
}

@end
