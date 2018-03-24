//
//  TTWebViewController.m
//  TTFeedback
//
//  Created by Ming on 2018/3/24.
//  Copyright © 2018年 Sara. All rights reserved.
//

#import "TTWebViewController.h"
#import "TTWebProgressView.h"
#import "TTLinkerHandler.h"
#define  kNavHeight  (44.0 + [UIApplication sharedApplication].statusBarFrame.size.height)


@interface TTWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic ,strong) WKWebView *webView;
@property (nonatomic, strong) TTWebProgressView *progressView;
@end

@implementation TTWebViewController

#pragma mark init
-(WKWebView *)webView{
    if (!_webView) {
          _webView=[[WKWebView alloc]init];
        _webView.backgroundColor=[UIColor redColor];
        _webView.navigationDelegate=self;
        _webView.UIDelegate=self;
        [self.view addSubview:_webView];
        _webView.translatesAutoresizingMaskIntoConstraints=NO;
        NSString *hCon=@"H:|[webView]|";
        NSArray *contraits=[NSLayoutConstraint constraintsWithVisualFormat:hCon options:0 metrics:nil views:@{@"webView":_webView}];
        [self.view addConstraints:contraits];
        NSString *vCon=@"V:|[webView]|";
        NSArray *contraits2=[NSLayoutConstraint constraintsWithVisualFormat:vCon options:0 metrics:nil views:@{@"webView":_webView}];
        [self.view addConstraints:contraits2];
    }
    return _webView;
}
-(TTWebProgressView *)progressView{
    if (!_progressView) {
        _progressView=[[TTWebProgressView alloc]init];
        [self.webView addSubview:_progressView];
        _progressView.translatesAutoresizingMaskIntoConstraints=NO;
        NSString *hCon=@"H:|[progressView]|";
        NSArray *contraits=[NSLayoutConstraint constraintsWithVisualFormat:hCon options:0 metrics:nil views:@{@"progressView":_progressView}];
        [self.view addConstraints:contraits];
        NSString *vCon=@"V:|-top-[progressView(30)]";
        NSArray *contraits2=[NSLayoutConstraint constraintsWithVisualFormat:vCon options:0 metrics:@{@"top":@(kNavHeight)} views:@{@"progressView":_progressView}];
        [self.view addConstraints:contraits2];
        
    }
    return _progressView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.xiao-bai.cn/index.html"]]];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"1");
    [self.progressView startLoading];
    
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressView stopLoading];
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tantanapp"]) {
      
        id vc= [TTLinkerHandler handleDealWithHref:URL];
        [self.navigationController pushViewController:vc animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
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
