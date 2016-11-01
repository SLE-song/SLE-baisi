//
//  SLEAddTagToolbar.m
//  百思不得姐
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEAddTagToolbar.h"
#import "SLEAddTagController.h"

@interface SLEAddTagToolbar()
/** 工具条的顶部 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;

/** 所有的标签 */
@property (strong ,nonatomic) NSMutableArray *tagLabels;
@end


@implementation SLEAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}



- (void)awakeFromNib
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    button.sle_size = button.currentImage.size;
    button.sle_x = SLETopicCellMargin;
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:button];
    self.addButton = button;
    // 默认就有两个标签
    [self creatTagLabels:@[@"吐槽",@"糗事"]];

}

- (void)addButtonClick
{

    SLEAddTagController *addtagVc = [[SLEAddTagController alloc] init];
    __weak typeof(self)weakSelf = self;
    
    [addtagVc setTagsBlock:^(NSArray *tags) {
        
        [weakSelf creatTagLabels:tags];
        
    }];
    addtagVc.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)vc.presentedViewController;
    [nav pushViewController:addtagVc animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.sle_x = 0;
            tagLabel.sle_y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SLETagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.sle_width - leftWidth;
            if (rightWidth >= tagLabel.sle_width) { // 按钮显示在当前行
                tagLabel.sle_y = lastTagLabel.sle_y;
                tagLabel.sle_x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.sle_x = 0;
                tagLabel.sle_y = CGRectGetMaxY(lastTagLabel.frame) + SLETagMargin;
            }
        }
        
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SLETagMargin;
    
    // 更新textField的frame
    if (self.topView.sle_width - leftWidth >= self.addButton.sle_width) {
        self.addButton.sle_y = lastTagLabel.sle_y;
        self.addButton.sle_x = leftWidth;
    } else {
        self.addButton.sle_x = 0;
        self.addButton.sle_y = CGRectGetMaxY(lastTagLabel.frame) + SLETagMargin;
    }
    
    CGFloat oldH = self.sle_height;
    self.sle_height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.sle_y -= self.sle_height - oldH;

    

}


- (void)creatTagLabels:(NSArray *)tags
{

    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = SLETagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = SLETagFont;
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.sle_width += 2 * SLETagMargin;
        tagLabel.sle_height = SLETagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    [self setNeedsLayout];
}




+ (instancetype)sle_addTagToolbar
{


    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

@end
