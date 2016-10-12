//
//  MKWebViewController.m
//  百思不得姐
//
//  Created by Mark Kent on 16/10/12.
//  Copyright © 2016年 Mark Kent. All rights reserved.
//

#import "MKWebViewController.h"

@interface MKWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *foward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;

@end

@implementation MKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
- (IBAction)back:(id)sender {
    [self.webView goBack];
}
- (IBAction)foward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark -- UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {

    self.back.enabled = self.webView.canGoBack;
    self.foward.enabled = self.webView.canGoForward;
}

@end
