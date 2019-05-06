//
//  ZYViewController.m
//  ZYAuth
//
//  Created by 378804441@qq.com on 05/06/2019.
//  Copyright (c) 2019 378804441@qq.com. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYAuthManager.h"

//#define IMPORT_WECHAT

@interface ZYViewController ()

@end

@implementation ZYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [ZYAuthManager shareInstance];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
