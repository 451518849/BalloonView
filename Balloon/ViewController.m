//
//  ViewController.m
//  Balloon
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"item1";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.center = self.view.center;
    label.text = @"这是第一个界面";
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
