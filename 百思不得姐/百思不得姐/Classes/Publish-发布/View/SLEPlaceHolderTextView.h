//
//  SLEPlaceHolderTextView.h
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLEPlaceHolderTextView : UITextView
/** 占位文字 */
@property (copy ,nonatomic) NSString *placeHolder;
/** 占位文字 */
@property (strong ,nonatomic) UIColor *placeHolderColor;

@end
