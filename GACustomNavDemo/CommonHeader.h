//
//  CommonHeader.h
//  hhhhDemo
//
//  Created by Gamin on 2020/8/8.
//  Copyright © 2020 gamin.com. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

#import "UIView+TransitonColor.h"
#import "UIView+LYKit.h"
#import "UIColor+HexColor.h"
#import "UIView+YND.h"
#import "UIImage+Extension.h"
#import "UIButton+Extension.h"
#import "NSString+Category.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE_X (SCREENHEIGHT == 812.0f || SCREENHEIGHT == 896.0f) ? YES : NO
#define NAVBARHEIGHT  ((IS_IPHONE_X== YES)?88.0f: 64.0f)
#define HeightStatusBar ((IS_IPHONE_X == YES)?44.0f: 20.0f)

/// CGRect
#define Rect(x, y, w, h) CGRectMake((x), (y), (w), (h))
/// CGSize
#define Size(w, h) CGSizeMake((w), (h))
/// CGPoint
#define Point(x, y) CGPointMake((x), (y))

#define HexColor(hexString) [UIColor colorWithHexString:(hexString)]
#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]

//图片 URL
#define ImageWithName(nameString) [UIImage imageNamed:nameString]

///  主题色
#define ThemeTitleColor HexColorInt32_t(FFFFFF)

///  安全运行block
#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;


#endif /* CommonHeader_h */
