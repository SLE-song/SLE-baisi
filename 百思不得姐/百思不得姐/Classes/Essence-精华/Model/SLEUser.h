//
//  SLEUser.h
//  百思不得姐
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLEUser : NSObject

/** 用户名 */
@property (copy ,nonatomic) NSString *username;
/** 用户头像 */
@property (copy ,nonatomic) NSString *profile_image;
/** 性别 */
@property (copy ,nonatomic) NSString *sex;

@end
