//
//  SLEPushGuideView.m
//  百思不得姐
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEPushGuideView.h"

@implementation SLEPushGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype)sle_loadGuideView
{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

+ (void)sle_showGuideView
{
    NSString *key = @"CFBundleShortVersionString";
    
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        SLEPushGuideView *guideView = [SLEPushGuideView sle_loadGuideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


}

- (IBAction)close {
    
    [self removeFromSuperview];
    
}


@end
