//
//  SLEConst.h
//  百思不得姐
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  帖子的类型
 */
typedef enum{
    
    SLETopicTypeAll = 1,
    SLETopicTypePicture = 10,
    SLETopicTypeWord = 29,
    SLETopicTypeVoice = 31,
    SLETopicTypeVideo = 41
    
    
} SLETopicType;


/** 精华--顶部工具条的高度 */
UIKIT_EXTERN CGFloat const SLETitleViewH;
/** 精华--顶部工具条的 Y 值 */
UIKIT_EXTERN CGFloat const SLETitleViewY;

/** 精华--topicCell底部工具条的高度 */
UIKIT_EXTERN CGFloat const SLETopicCellBottomH;
/** 精华--topicCell的间距 */
UIKIT_EXTERN CGFloat const SLETopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const SLETopicCellTextY;

/** 精华-cell-图片最大的高度 */
UIKIT_EXTERN CGFloat const SLETopicCellMaxH;
/** 精华-cell-图片最大的高度需要显示的高度 */
UIKIT_EXTERN CGFloat const SLETopicCellPictureBreakH;



/** 用户模型SLEUser性别属性值 */
UIKIT_EXTERN NSString *const SLEUserSexMale;
UIKIT_EXTERN NSString *const SLEUserSexFemale;



/** tabBarcontroller 被选中的通知的 key */
UIKIT_EXTERN NSString *const SLETabBarControllerDidSelectedKey;



/** 标签按钮以及label之间的间距 */
UIKIT_EXTERN CGFloat const SLETagMargin;
/** 标签按钮以及label高度 */
UIKIT_EXTERN CGFloat const SLETagH;



