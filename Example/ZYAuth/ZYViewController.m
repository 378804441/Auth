//
//  ZYViewController.m
//  ZYAuth
//
//  Created by 378804441@qq.com on 05/06/2019.
//  Copyright (c) 2019 378804441@qq.com. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYAuthManager.h"


@interface ZYViewController ()

@end

@implementation ZYViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIButton *wxBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 80, 30)];
    wxBtn.backgroundColor = [UIColor yellowColor];
    wxBtn.tag = 0;
    [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [wxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    
    
    
    UIButton *wbBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wxBtn.frame)+50, 300, 80, 30)];
    wbBtn.backgroundColor = [UIColor yellowColor];
    wbBtn.tag = 2;
    [wbBtn setTitle:@"微博登录" forState:UIControlStateNormal];
    [wbBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wbBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wbBtn];
}



-(void)authLogin:(UIButton *)btn{
    
    [[ZYAuthManager shareInstance] authLoginWithType:btn.tag viewController:self success:^(BOOL isSuccess, NSString * _Nullable errorMsg) {
        
    } failure:^(BOOL isSuccess, NSString * _Nullable errorMsg, NSString * _Nullable openid, NSString * _Nullable accessToken, NSString * _Nullable appID, NSDictionary * _Nullable dicProfile) {
        NSLog(@"~~~~~~  %@", errorMsg);
    }];
    
}

@end
