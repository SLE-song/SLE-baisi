//
//  SLEAddTagController.m
//  百思不得姐
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEAddTagController.h"
#import "SLETagButton.h"
#import "SLETagField.h"
#import <SVProgressHUD.h>

@interface SLEAddTagController ()<UITextFieldDelegate>
/** 中间部分 */
@property (weak ,nonatomic) UIView *contentView;
/** textField */
@property (weak ,nonatomic) UITextField *textField;
/** 提示按钮 */
@property (weak ,nonatomic) UIButton *addButton;
/** 添加标签按钮 */
@property (strong ,nonatomic) NSMutableArray *tagButtons;

@end

@implementation SLEAddTagController


#pragma mark-----懒加载
/*
 *  懒加载
 */
- (NSMutableArray *)tagButtons
{
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
    }

    return _tagButtons;
}
- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.backgroundColor = SLEColor(74, 139, 209);
        addButton.sle_width = self.contentView.sle_width;
        addButton.sle_height = 35;
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, SLETagMargin, 0, SLETagMargin);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    
    return _addButton;
}

#pragma mark -- 初始化
/*
 *  初始化
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextField];
    [self setupTags];
    
    
}

- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonDidClick];
    }
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    contentView.sle_x = SLETopicCellMargin;
    contentView.sle_y = 64 + SLETopicCellMargin;
    contentView.sle_width = self.view.sle_width - 2 *SLETopicCellMargin;
    contentView.sle_height = SLEScreenH;
    
    self.contentView = contentView;
    
}
- (void)setupTextField
{
    __weak typeof(self) weakSelf = self;
    SLETagField *textField = [[SLETagField alloc] init];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.deleteBlock = ^{
    
        if (weakSelf.textField.hasText) return;
            
        [weakSelf tagButtonDidClick:[weakSelf.tagButtons lastObject]];
    
    };
    textField.sle_width = SLEScreenW;
    textField.sle_height = 25;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    [textField becomeFirstResponder];
    self.textField = textField;
    
}

- (void)setupNav
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateDisabled];
    //    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
    
    
}


#pragma mark -- 监听文字改变
/*
 *  监听文字改变
 */
- (void)textDidChange
{
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
        self.addButton.sle_y = CGRectGetMaxY(self.textField.frame) + SLETagMargin;
        
        NSString *text = self.textField.text;
        NSInteger length = self.textField.text.length;
        NSString *lastStri = [text substringFromIndex:length - 1];
        
        if ([lastStri isEqualToString:@","] || [lastStri isEqualToString:@"，"] ) {
            
            text = [text substringToIndex:length - 1];
            self.textField.text = text;
            [self addButtonDidClick];
        }
        
        
        [self updateTextFieldFrame];
    }else{
        
        self.addButton.hidden = YES;
    }
    
    
}



//static CGFloat SLETagMargin = 5;




#pragma mark------ 监听按钮点击
- (void)addButtonDidClick
{
    if (self.tagButtons.count >=5) {
        
//        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    SLETagButton *tagButton = [SLETagButton buttonWithType:UIButtonTypeCustom];
    
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.sle_height = self.textField.sle_height;
    
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    [self updateAddButtonFrame];
    
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
- (void)tagButtonDidClick:(SLETagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    [UIView animateWithDuration:0.2 animations:^{
        
        [self updateAddButtonFrame];
    }];
}

- (void)complete
{
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark------ 更新按钮 和 textField 的frame
- (void)updateAddButtonFrame
{

    for (int i =0; i < self.tagButtons.count; i ++) {
        
        SLETagButton *tagButton = self.tagButtons[i];
        [tagButton addTarget:self action:@selector(tagButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            tagButton.sle_x = 0;
            tagButton.sle_y = 0;
        }else{
        
            SLETagButton *lastButton = self.tagButtons[i-1];
            CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + SLETagMargin;
            CGFloat rightWidth = self.contentView.sle_width - leftWidth;
            if (rightWidth >= tagButton.sle_width) {
                tagButton.sle_y = lastButton.sle_y;
                tagButton.sle_x = leftWidth;
            }else{
                tagButton.sle_x = 0;
                tagButton.sle_y = CGRectGetMaxY(lastButton.frame) + SLETagMargin;
                
            }
        }
        
    }

    [self updateTextFieldFrame];

}

- (void)updateTextFieldFrame
{
    SLETagButton *lastButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + SLETagMargin;
    
    if ((self.contentView.sle_width - leftWidth) >= [self textFieldWidth] ) {
        self.textField.sle_y = lastButton.sle_y;
        self.textField.sle_x = leftWidth;
    }else{
        
        self.textField.sle_x = 0;
        self.textField.sle_y = CGRectGetMaxY(lastButton.frame) + SLETagMargin;
    }


}


#pragma mark------ 计算textField的宽度
- (CGFloat)textFieldWidth
{

    
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);

}



#pragma mark -- <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (textField.hasText) {
        [self addButtonDidClick];
    }
    
    return YES;

}



@end
