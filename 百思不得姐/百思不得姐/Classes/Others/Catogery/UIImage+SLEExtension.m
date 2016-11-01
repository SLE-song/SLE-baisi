//
//  UIImage+SLEExtension.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "UIImage+SLEExtension.h"

@implementation UIImage (SLEExtension)

- (UIImage *)sle_circleImage
{
    
//    CGSize size = CGSizeMake(, <#CGFloat height#>)
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();


    return image;

}
@end
