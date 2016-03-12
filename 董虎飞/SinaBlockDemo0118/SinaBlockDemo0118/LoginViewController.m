//
//  LoginViewController.m
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import "LoginViewController.h"
#import "HTTPRequest.h"

@interface LoginViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)HTTPRequest *request;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[HTTPRequest getLoginURL]]];
    
    webView.delegate = self;
    
    self.view = webView;
    
    [webView release];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.absoluteString containsString:@"code="]) {
        
        NSString *code = [[request.URL.absoluteString componentsSeparatedByString:@"code="] lastObject];
        
        _request = [[HTTPRequest alloc]init];
        
        [_request getAccesstokenWithCode:code];
        
        [_request setGetAccesstokenSuccess:^(NSString *access_token) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getAccessTokenSuccess();
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
        return NO;
    }
    
    return YES;
}

- (void)dealloc {
    self.getAccessTokenSuccess = nil;
    self.request = nil;
    [super dealloc];
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

@end
