//
//  BalloonView.m
//  Balloon
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "BalloonView.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen]bounds].size.height

#define SMALLEST_SCALE 0.3   //shrink the balloons before move
#define BIGGEST_SCALE 1.3    // amplify the ballons when arrive end

#define MOVING_TIME 1       // the time of balloons moving from origin to end

#define SMALL_SIZE_OF_BALLOON 80         //the size of small balloon
#define BIG_SIZE_OF_BALLOON 150         //the size of big balloon

#define AMPLITUDE 2                 // the amplitude of the balloon
#define SWING_TIME  1               // the duration of swing

@interface BalloonView ()
@property(nonatomic,strong)NSArray *balloonImages;
@property(nonatomic,strong)NSArray *taps;
@property(nonatomic,strong)UIImageView *balloon1;
@property(nonatomic,strong)UIImageView *balloon2;
@property(nonatomic,strong)UIImageView *balloon3;
@property(nonatomic,strong)UIImageView *balloon4;
@property(nonatomic,strong)UIImageView *balloon5;

@property(nonatomic,assign)CGPoint originPoint1;
@property(nonatomic,assign)CGPoint originPoint2;
@property(nonatomic,assign)CGPoint originPoint3;
@property(nonatomic,assign)CGPoint originPoint4;
@property(nonatomic,assign)CGPoint originPoint5;

@end

@implementation BalloonView

-(id)initWithFrame:(CGRect)frame balloonImages:(NSArray*)images
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _balloonImages = images;
        self.userInteractionEnabled = YES;
        [self setPointForBalloon:images];
    }

    return self;
    
}

//to set the origin point for all balloons ,the origin point has been arranged in advance
-(void)setPointForBalloon:(NSArray*)images;
{
    _balloon1 = [[UIImageView alloc]initWithImage:[images objectAtIndex:0]];
    _balloon2 = [[UIImageView alloc]initWithImage:[images objectAtIndex:1]];
    _balloon3 = [[UIImageView alloc]initWithImage:[images objectAtIndex:2]];
    _balloon4 = [[UIImageView alloc]initWithImage:[images objectAtIndex:3]];
    _balloon5 = [[UIImageView alloc]initWithImage:[images objectAtIndex:4]];

    _balloon1.frame = CGRectMake(-120, SCREEN_HEIGHT-100, BIG_SIZE_OF_BALLOON, BIG_SIZE_OF_BALLOON);
    _balloon2.frame = CGRectMake(-100, SCREEN_HEIGHT-200, SMALL_SIZE_OF_BALLOON, SMALL_SIZE_OF_BALLOON);
    _balloon3.frame = CGRectMake(-100, SCREEN_HEIGHT-300, SMALL_SIZE_OF_BALLOON, SMALL_SIZE_OF_BALLOON);
    _balloon4.frame = CGRectMake(SCREEN_WIDTH+100, SCREEN_HEIGHT-100, SMALL_SIZE_OF_BALLOON, SMALL_SIZE_OF_BALLOON);
    _balloon5.frame = CGRectMake(SCREEN_WIDTH+100, SCREEN_HEIGHT-100, SMALL_SIZE_OF_BALLOON, SMALL_SIZE_OF_BALLOON);

    _originPoint1 = _balloon1.center;
    _originPoint2 = _balloon2.center;
    _originPoint3 = _balloon3.center;
    _originPoint4 = _balloon4.center;
    _originPoint5 = _balloon5.center;

    _balloon1.userInteractionEnabled = YES;
    _balloon2.userInteractionEnabled = YES;
    _balloon3.userInteractionEnabled = YES;
    _balloon4.userInteractionEnabled = YES;
    _balloon5.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(hidedWhenSelectedBalloon:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(hidedWhenSelectedBalloon:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(hidedWhenSelectedBalloon:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(hidedWhenSelectedBalloon:)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(hidedWhenSelectedBalloon:)];
    _taps = @[tap1,tap2,tap3,tap4,tap5];
    
    [_balloon1 addGestureRecognizer:tap1];
    [_balloon2 addGestureRecognizer:tap2];
    [_balloon3 addGestureRecognizer:tap3];
    [_balloon4 addGestureRecognizer:tap4];
    [_balloon5 addGestureRecognizer:tap5];

    [self addSubview:_balloon2];
    [self addSubview:_balloon3];
    [self addSubview:_balloon4];
    [self addSubview:_balloon5];
    [self addSubview:_balloon1];

}

-(void)startBalloonAnimation;
{
    [self endAnimationForBalloonView:_balloon1 withEndPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) andSwingDirection:2];
    [self endAnimationForBalloonView:_balloon2 withEndPoint:CGPointMake(SCREEN_WIDTH/2-90,  SCREEN_HEIGHT/2-100) andSwingDirection:1.5];
    [self endAnimationForBalloonView:_balloon3 withEndPoint:CGPointMake(SCREEN_WIDTH/2-80,  SCREEN_HEIGHT/2+90) andSwingDirection:-1];
    [self endAnimationForBalloonView:_balloon4 withEndPoint:CGPointMake(SCREEN_WIDTH/2+100,  SCREEN_HEIGHT/2-60) andSwingDirection:-1.5];
    [self endAnimationForBalloonView:_balloon5 withEndPoint:CGPointMake(SCREEN_WIDTH/2+90,  SCREEN_HEIGHT/2+70) andSwingDirection:1];

}

// the move of balloon to endpoint
-(void)endAnimationForBalloonView:(UIImageView*)balloon withEndPoint:(CGPoint)endPoint andSwingDirection:(int)number
;
{
    balloon.transform = CGAffineTransformMakeScale(SMALLEST_SCALE, SMALLEST_SCALE);
    
    [UIView animateWithDuration:MOVING_TIME
                     animations:^{
                         balloon.alpha = 1;
                         balloon.transform = CGAffineTransformMakeScale(BIGGEST_SCALE, BIGGEST_SCALE);
                         balloon.center = endPoint;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:1.0
                                          animations:^{
                                              
                                              balloon.transform = CGAffineTransformMakeScale(1, 1);
                                              
                                          } completion:^(BOOL finished) {
                                              
                                              [self swingRoundWithBalloon:balloon andSwingDirection:number];
                                              
                                          }];
                     }];
}

// when selected balloon , the balloons will move to origin point
-(void)hidedWhenSelectedBalloon:(UITapGestureRecognizer*)tap
{
    NSInteger index = [_taps indexOfObject:tap];
    [_delegate balloonViewDidSelected:index];
    
    [UIView animateWithDuration:MOVING_TIME
                     animations:^{
                         
                         _balloon1.alpha = 0.0;
                         _balloon2.alpha = 0.0;
                         _balloon3.alpha = 0.0;
                         _balloon4.alpha = 0.0;
                         _balloon5.alpha = 0.0;

                         _balloon1.center = _originPoint1;
                         _balloon2.center = _originPoint2;
                         _balloon3.center = _originPoint3;
                         _balloon4.center = _originPoint4;
                         _balloon5.center = _originPoint5;
                         
                         _balloon1.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon2.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon3.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon4.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon5.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                         
                     }];}

-(void)backToOriginPoint;
{
    [UIView animateWithDuration:MOVING_TIME
                     animations:^{
                         
                         _balloon1.alpha = 0.0;
                         _balloon2.alpha = 0.0;
                         _balloon3.alpha = 0.0;
                         _balloon4.alpha = 0.0;
                         _balloon5.alpha = 0.0;
                         
                         _balloon1.center = _originPoint1;
                         _balloon2.center = _originPoint2;
                         _balloon3.center = _originPoint3;
                         _balloon4.center = _originPoint4;
                         _balloon5.center = _originPoint5;
                         
                         _balloon1.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon2.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon3.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon4.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         _balloon5.transform = CGAffineTransformMakeScale(0.5, 0.5);
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];

                     }];
}

// swing the balloons
-(void)swingRoundWithBalloon:(UIImageView*)balloon andSwingDirection:(int)number
{
    [UIView animateWithDuration:SWING_TIME
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|
     UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         balloon.center = CGPointMake(balloon.center.x-number, balloon.center.y+number);
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:SWING_TIME
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction|
                          UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              
                                              balloon.center = CGPointMake(balloon.center.x+number, balloon.center.y+number);
                                              
                                              
                                          } completion:^(BOOL finished) {
                                              [UIView animateWithDuration:SWING_TIME
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction|
                                               UIViewAnimationOptionCurveLinear
                                                               animations:^{
                                                                   
                                                                   balloon.center = CGPointMake(balloon.center.x+number, balloon.center.y-number);
                                                                   
                                                               } completion:^(BOOL finished) {
                                                                   
                                                                   [UIView animateWithDuration:SWING_TIME
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction|
                                                                    UIViewAnimationOptionCurveLinear
                                                                                    animations:^{
                                                                                        
                                                                                        balloon.center = CGPointMake(balloon.center.x-number, balloon.center.y-number);
                                                                                        
                                                                                    } completion:^(BOOL finished) {
                                                                                        
                                                                                        [self swingRoundWithBalloon:balloon andSwingDirection:number];
                                                                                        
                                                                                    }];
                                                               }];
                                          }];
                     }];
}

@end
