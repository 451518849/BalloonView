//
//  SecondViewController.m
//  Balloon
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"item2";

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.center = self.view.center;
    label.text = @"这是第二个界面";
    [self.view addSubview:label];
    
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
