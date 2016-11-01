//
//  UIView+SLEExtention.m
//  百思不得姐
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "UIView+SLEExtention.h"

@implementation UIView (SLEExtention)

/** set 方法 */
- (void)setSle_width:(CGFloat)sle_width
{

    CGRect tmpFrame = self.frame;
    tmpFrame.size.width = sle_width;
    self.frame = tmpFrame;

}


- (void)setSle_height:(CGFloat)sle_height
{
    
    CGRect tmpFrame = self.frame;
    tmpFrame.size.height = sle_height;
    self.frame = tmpFrame;
    
}


- (void)setSle_x:(CGFloat)sle_x
{
    
    CGRect tmpFrame = self.frame;
    tmpFrame.origin.x = sle_x;
    self.frame = tmpFrame;
    
}

- (void)setSle_y:(CGFloat)sle_y
{
    
    CGRect tmpFrame = self.frame;
    tmpFrame.origin.y = sle_y;
    self.frame = tmpFrame;
    
}

- (void)setSle_size:(CGSize)sle_size
{

    CGRect tmpFrame = self.frame;
    tmpFrame.size = sle_size;
    self.frame = tmpFrame;

}

- (void)setSle_centerX:(CGFloat)sle_centerX
{
    CGPoint center = self.center;
    center.x = sle_centerX;
    self.center = center;
    
}


- (void)setSle_centerY:(CGFloat)sle_centerY
{
    CGPoint center = self.center;
    center.y = sle_centerY;
    self.center = center;
    
}

/** get 方法 */
- (CGFloat)sle_width
{

    return self.frame.size.width;
}

- (CGFloat)sle_height
{
    
    return self.frame.size.height;
}

- (CGFloat)sle_x
{
    
    return self.frame.origin.x;
}

- (CGFloat)sle_y
{
    
    return self.frame.origin.y;
}

- (CGSize)sle_size
{

    return self.frame.size;
}
- (CGFloat)sle_centerX
{
    
    return self.center.x;
}
- (CGFloat)sle_centerY
{
    
    return self.center.y;
}


- (BOOL)sle_isShowingOnKeyWindow
{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect keyWidowBounds = keyWindow.bounds;
    
    BOOL interects = CGRectIntersectsRect(newFrame, keyWidowBounds);

    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && interects;

}




@end
