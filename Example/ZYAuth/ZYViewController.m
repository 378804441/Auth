//
//  ZYViewController.m
//  ZYAuth
//
//  Created by 378804441@qq.com on 05/06/2019.
//  Copyright (c) 2019 378804441@qq.com. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYAuthManager.h"
#import "ZYShareModel.h"

@interface ZYViewController ()

@end

@implementation ZYViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIButton *wxBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 100, 30)];
    wxBtn.backgroundColor = [UIColor yellowColor];
    wxBtn.tag = 0;
    [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [wxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    
    UIButton *qqBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(wxBtn.frame)+20, CGRectGetMinY(wxBtn.frame), 100, 30)];
    qqBtn.backgroundColor = [UIColor yellowColor];
    qqBtn.tag = 1;
    [qqBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
    [qqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    UIButton *wbBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(qqBtn.frame)+20, CGRectGetMinY(wxBtn.frame), 100, 30)];
    wbBtn.backgroundColor = [UIColor yellowColor];
    wbBtn.tag = 2;
    [wbBtn setTitle:@"微博登录" forState:UIControlStateNormal];
    [wbBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wbBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wbBtn];
    
    
    /****************************** google ***********************************/
    UIButton *googleBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(wxBtn.frame), CGRectGetMaxY(wxBtn.frame)+20, wxBtn.frame.size.width, wxBtn.frame.size.height)];
    googleBtn.backgroundColor = [UIColor yellowColor];
    googleBtn.tag = 3;
    [googleBtn setTitle:@"Google登录" forState:UIControlStateNormal];
    [googleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [googleBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:googleBtn];
    
    
    UIButton *googleOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(googleBtn.frame)+20, CGRectGetMaxY(wxBtn.frame)+20, wxBtn.frame.size.width, wxBtn.frame.size.height)];
    googleOutBtn.backgroundColor = [UIColor yellowColor];
    googleOutBtn.tag = 103;
    [googleOutBtn setTitle:@"Google登出" forState:UIControlStateNormal];
    [googleOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [googleOutBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:googleOutBtn];
    
    
    /****************************** Facebook ***********************************/
    UIButton *facebookBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(wxBtn.frame), CGRectGetMaxY(googleBtn.frame)+20, wxBtn.frame.size.width, wxBtn.frame.size.height)];
    facebookBtn.backgroundColor = [UIColor yellowColor];
    facebookBtn.tag = 4;
    [facebookBtn setTitle:@"FB登录" forState:UIControlStateNormal];
    [facebookBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookBtn];
    
    
    /****************************** t ***********************************/
    UIButton *twitterBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(wxBtn.frame), CGRectGetMaxY(facebookBtn.frame)+20, wxBtn.frame.size.width, wxBtn.frame.size.height)];
    twitterBtn.backgroundColor = [UIColor yellowColor];
    twitterBtn.tag = 5;
    [twitterBtn setTitle:@"Twitter登录" forState:UIControlStateNormal];
    [twitterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [twitterBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterBtn];
    
    
    /****************************** w ***********************************/
    UIButton *whatsappBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(wxBtn.frame), CGRectGetMaxY(twitterBtn.frame)+20, wxBtn.frame.size.width, wxBtn.frame.size.height)];
    whatsappBtn.backgroundColor = [UIColor yellowColor];
    whatsappBtn.tag = 6;
    [whatsappBtn setTitle:@"whatsapp登录" forState:UIControlStateNormal];
    [whatsappBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [whatsappBtn addTarget:self action:@selector(authLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:whatsappBtn];
    
}



-(void)authLogin:(UIButton *)btn{
    
    
}

@end
