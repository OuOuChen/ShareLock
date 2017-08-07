//
//  WebViewController.h
//  T21info
//
//  Created by 陈区 on 12-11-8.
//  Copyright (c) 2012年 陈区. All rights reserved.
//

#import "COBaseViewController.h"
#import "WebViewController.h"



@interface WebViewController : COBaseViewController
<UIWebViewDelegate>
{
    UIWebView *m_WebView;
    
    UIActivityIndicatorView * loadWebWaiting;//下载等待框
    
    NSString *m_WebURL;
    

}

@property(nonatomic,strong)NSString *webURL;








@end
