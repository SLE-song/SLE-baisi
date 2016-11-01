//
//  SLEMeWebController.m
//  百思不得姐
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 slebaisitu. All rights reserved.
//

#import "SLEMeWebController.h"
#import <NJKWebViewProgress.h>

@interface SLEMeWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *go;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;

@end

@implementation SLEMeWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    weakSelf.progress.progressBlock = ^(float progress){
    
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
        
        
    };
    
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)back:(id)sender {
    
    [self.webView goBack];
}
- (IBAction)go:(id)sender {
    
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

@end
