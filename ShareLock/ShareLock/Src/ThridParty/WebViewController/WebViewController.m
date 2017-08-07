//
//  WebViewController.m
//  T21info
//
//  Created by 陈区 on 12-11-8.
//  Copyright (c) 2012年 陈区. All rights reserved.
//

#import "WebViewController.h"





@implementation WebViewController
@synthesize webURL = m_WebURL;


#pragma mark -CustomFun



#pragma mark -init

- (void)loadView
{
    
    CGRect appbounds = CGRectMake(0,0, kScreenWidth, kScreenHeight);

    UIView *mainView = [[UIView alloc] initWithFrame:appbounds];
    
    m_WebView = [[UIWebView alloc] initWithFrame:mainView.bounds];
    m_WebView.delegate = self;
    [(UIScrollView *)[[m_WebView subviews] objectAtIndex:0]    setBounces:NO];
    [mainView addSubview:m_WebView];
    
    
    loadWebWaiting=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadWebWaiting.frame = CGRectMake((appbounds.size.width-60)/2, (appbounds.size.height-60)/2, 60, 60);
    loadWebWaiting.hidesWhenStopped = YES;
    [mainView addSubview:loadWebWaiting];
    
    mainView.backgroundColor=[UIColor whiteColor];
    self.view = mainView;
    
   
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL *url = [NSURL URLWithString:self.webURL];
    
    if ([self.webURL length]>0 && url==nil)
    {
        url=[NSURL fileURLWithPath: self.webURL];//本地
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [m_WebView loadRequest:request];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [loadWebWaiting startAnimating];
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    //更新标题
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = theTitle;
    
    [loadWebWaiting stopAnimating];
    

}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [loadWebWaiting stopAnimating];
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return YES;
}






@end
