//
//  BalloonView.h
//  Balloon
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BalloonDelegate <NSObject>

-(void)balloonViewDidSelected:(NSInteger)index;

@end

@interface BalloonView : UIView

@property(nonatomic,assign)id<BalloonDelegate>delegate;

-(id)initWithFrame:(CGRect)frame balloonImages:(NSArray*)images;

//balloons move to center of the view
-(void)startBalloonAnimation;

//balloons move back to origin and hide
-(void)backToOriginPoint;
@end
