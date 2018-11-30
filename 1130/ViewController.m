//
//  ViewController.m
//  1130
//
//  Created by dqh on 2017/11/30.
//  Copyright © 2017年 juesheng. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    back.backgroundColor = [UIColor greenColor];
    [back addTarget:self action:@selector(bakcAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

    UIButton *backTwo = [[UIButton alloc] initWithFrame:CGRectMake(30, 130, 40, 40)];
    backTwo.backgroundColor = [UIColor greenColor];
    backTwo.tag = 10;
    [backTwo addTarget:self action:@selector(bakcAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backTwo];


    UIButton *backThree = [[UIButton alloc] initWithFrame:CGRectMake(30, 230, 100, 40)];
    backThree.backgroundColor = [UIColor whiteColor];
    [backThree setImage:[UIImage imageNamed:@"icon_deng1_user"] forState:UIControlStateNormal];
    [backThree addTarget:self action:@selector(bakcAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backThree];
//    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    webview.navigationDelegate = self;
//    webview.backgroundColor = [UIColor redColor];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.13.116:8080/#/"]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    [webview loadRequest:request];
//    [self.view addSubview:webview];
//    self.webView = webview;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - delegate

#pragma mark - WKNavigationDelegate
/*
 * 在请求先判断能不能跳转（请求）
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //    NSString *hostName = navigationAction.request.URL.host;
    //    NSString *path = navigationAction.request.URL.path;
    NSLog(@"url = %@",navigationAction.request.URL.absoluteString);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 在响应完成时，会回调此方法
// 如果设置为不允许响应，web内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%s", __FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

// 接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
}


// 页面内容到达main frame时回调
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

// 导航完成时，会回调（也就是页面载入完成了）
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);

}

// 导航失败时会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
}

// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    NSLog(@"%s", __FUNCTION__);
    NSURLCredential *newCard = [NSURLCredential credentialWithUser:@"" password:@"" persistence:NSURLCredentialPersistenceNone];
    completionHandler(NSURLSessionAuthChallengeUseCredential, newCard);
}

// 进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - end

- (void)setButtonTitleAndImageMargin:(CGFloat)margin button:(UIButton *)button
{
    button.titleLabel.backgroundColor = button.backgroundColor;
    button.imageView.backgroundColor = button.backgroundColor;
    
    CGSize titleSize = [self textBoundingRect:CGSizeMake(1000, 1000) font:button.titleLabel.font text:button.titleLabel.text];
    CGSize imageSize = button.imageView.bounds.size;
    
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + margin, (button.frame.size.width - titleSize.width) / 2. - titleSize.width, 0, 0)];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, (button.frame.size.width - imageSize.width) / 2., button.frame.size.height - imageSize.height, 0.)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + margin, (button.frame.size.width - titleSize.width) / 2. - titleSize.width, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, (button.frame.size.width - imageSize.width) / 2., button.frame.size.height - imageSize.height, 0.)];
}


- (CGSize)textBoundingRect:(CGSize)size font:(UIFont *)font text:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

- (void)bakcAction:(UIButton *)sender
{
    if(sender.tag == 10) {
        TwoViewController *two = [[TwoViewController alloc] init];
        [self presentViewController:two animated:YES completion:nil];
    } else {
        OneViewController *one = [[OneViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:one];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
