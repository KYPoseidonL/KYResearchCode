//
//  KYWebViewViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/11/9.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "KYWebViewViewController.h"
#import "KYWebView.h"

#define URL1 @"http://mob40.feimaor.com/downloadApp.action?id=516516809&fmuid=311267&taskid=236&typeid=102&appos=1&url=http%3A%2F%2Fpage.feimaor.com%2Frec%2FQS_user2.htm"
#define URL2 @"http://mob40.feimaor.com/downloadApp.action?id=516368919&fmuid=344894&taskid=375&typeid=102&appos=1&url=http%3A%2F%2Fpage.feimaor.com%2Frec%2Fcaimimao_fm.htm"

@interface KYWebViewViewController ()
{
    KYWebView *_webView;
}
@end

@implementation KYWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"网页复制、粘贴";
    
    [self setup];
}

- (void)setup {
    
    _webView = [[KYWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL1]];
    [_webView loadRequest:request];
    
}

@end
