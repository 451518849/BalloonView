//
//  BallTabBarViewController.m
//  Balloon
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "BallTabBarViewController.h"
#import "SecondViewController.h"
#import "ViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"

#import "BalloonView.h"
@interface BallTabBarViewController ()<BalloonDelegate>
@property(nonatomic,strong)BalloonView *balloonView;

@end

@implementation BallTabBarViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.title = @"item1";
    
    UIImage *image1 = [UIImage imageNamed:@"balloon"];
    UIImage *image2 = [UIImage imageNamed:@"balloon"];
    UIImage *image3 = [UIImage imageNamed:@"balloon"];
    UIImage *image4 = [UIImage imageNamed:@"balloon"];
    UIImage *image5 = [UIImage imageNamed:@"balloon"];
    
    self.delegate = self;
    
    NSArray *images = @[image1,image2,image3,image4,image5];
    
    _balloonView = [[BalloonView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60) balloonImages:images];
    
    _balloonView.delegate = self;
    [_balloonView startBalloonAnimation];
    
    [self.view addSubview:_balloonView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)balloonViewDidSelected:(NSInteger)index;
{
    self.selectedIndex = index;
    NSLog(@"index:%ld",index);
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    if (tabBarController.selectedIndex == 0)
    {
        [self.view addSubview:_balloonView];
        [_balloonView startBalloonAnimation];
        
    }
    else
    {
        [_balloonView backToOriginPoint];
    }
    
    switch (tabBarController.selectedIndex) {
        case 0:
            self.title = @"item1";
            break;
        case 1:
            self.title = @"item2";
            break;
        case 2:
            self.title = @"item3";
            break;
        case 3:
            self.title = @"item4";
            break;
        case 4:
            self.title = @"item5";
            break;
        default:
            break;
    }
    
    NSLog(@"---%ld:",tabBarController.selectedIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
