//
//  SLEWordController.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEWordController.h"
#import "SLEPlaceHolderTextView.h"
#import "SLEAddTagToolbar.h"

@interface SLEWordController ()<UITextViewDelegate>
/** 文本输入框 */
@property (strong ,nonatomic) SLEPlaceHolderTextView *textView;
/** 底部工具条 */
@property (strong ,nonatomic) SLEAddTagToolbar *toolbar;

@end

@implementation SLEWordController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLEGlobalBg;
    [self setupNav];
    [self setupTextView];
    [self setupAddToolbar];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];

}


- (void)setupAddToolbar
{
    SLEAddTagToolbar *toolbar = [SLEAddTagToolbar sle_addTagToolbar];
    toolbar.sle_y = self.view.sle_height - toolbar.sle_height;
    toolbar.sle_width = self.view.sle_width;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)keyboardChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, frame.origin.y - SLEScreenH);
        
    }];
}
- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)setupTextView
{
    
    SLEPlaceHolderTextView *textView = [[SLEPlaceHolderTextView alloc] init];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    textView.delegate = self;
    [textView becomeFirstResponder];
    textView.placeHolder = @"这里添加文字，请勿发布色情、政治等违反国家法律的内容，违者封号处理";
    self.textView = textView;
}

- (void)setupNav
{
    
    self.title = @"发表文字";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];

}



- (void)cancle
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)post
{



}


#pragma mark ----uitextview delegate
- (void)textViewDidChange:(UITextView *)textView
{

    self.navigationItem.rightBarButtonItem.enabled = YES;

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];
}
@end
