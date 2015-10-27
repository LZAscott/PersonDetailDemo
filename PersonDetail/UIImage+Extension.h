//
//  UIImage+Extension.h
//  PersonDetail
//
//  Created by Scott_Mr on 15/10/23.
//  Copyright © 2015年 Scott_Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
