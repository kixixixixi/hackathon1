//
//  GameViewController.m
//  hackathon1
//
//  Created by kixixixixi on 2014/05/22.
//  Copyright (c) 2014年 kixixixixi. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:0.33 green:1.0 blue:0.33 alpha:1.0];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat iPhone5headSpace = 0;
    if (self.view.bounds.size.height > 480) {
        iPhone5headSpace = 28;
    }
    
    
    for (int i = 0; i < 2; i++) {
        UIImageView *toolBtn = [[UIImageView alloc]init];
        toolBtn.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0];
        toolBtn.frame = CGRectMake(100 + i*80, self.view.frame.size.height -100, 60, 60);
        toolBtn.layer.cornerRadius = 10;
        toolBtn.clipsToBounds = YES;
        toolBtn.tag = 101 +i;
        toolBtn.userInteractionEnabled = YES;
        [toolBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
        [self.view addSubview:toolBtn];
        
        UILabel *btnLabel = [[UILabel alloc]init];
        btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.textColor = [UIColor whiteColor];
        btnLabel.font = [UIFont boldSystemFontOfSize:60];
        btnLabel.frame = CGRectMake(0, 0, 60, 60);
        btnLabel.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                btnLabel.text = @"＋";
                break;
            case 1:
                btnLabel.text = @"−";
                break;
                
        }
        [toolBtn addSubview:btnLabel];
        
        CALayer *border = [CALayer layer];
        border.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
        border.frame = CGRectMake(0, 56, 60, 4);
        [toolBtn.layer addSublayer:border];
    }
    
    userCountLabel = [[UILabel alloc]init];
    userCountLabel.text = @"0";
    userCountLabel.textAlignment = NSTextAlignmentCenter;
    userCountLabel.textColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.66];
    userCountLabel.font = [UIFont boldSystemFontOfSize:30];
    userCountLabel.frame = CGRectMake(40, 40, 240, 40);
    userCountLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:userCountLabel];
    
    timerLabel = [[UILabel alloc]init];
    timerLabel.text = @"のこり8秒";
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.textColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:0.66];
    timerLabel.font = [UIFont boldSystemFontOfSize:24];
    timerLabel.frame = CGRectMake(40, 80, 240, 40);
    timerLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timerLabel];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.maxAmount = self.maxAmount ? self.maxAmount : 10;
    amountChara = ( arc4random() % (self.maxAmount/2) ) + self.maxAmount/2;
    
    charaImvArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < amountChara; i++) {
        
        int rndY = arc4random() % (int)(self.view.frame.size.height -100 -80 -80);
        int rndX = arc4random() % 10;
        
        UIImageView *charaImv = [[UIImageView alloc]init];
        charaImv.image = [UIImage imageNamed:@"hiyo.png"];
        charaImv.frame = CGRectMake(320 +80 +rndX, 80 +rndY, 60, 60);
        charaImv.layer.cornerRadius = 10;
        charaImv.clipsToBounds = YES;
        charaImv.tag = 1001 +i;
        charaImv.userInteractionEnabled = YES;
        [charaImv addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
        [self.view addSubview:charaImv];
        
        [charaImvArray addObject:charaImv];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    for ( UIImageView *charaImv in charaImvArray )
    {
        int rndX = arc4random() % 400;
        int rndDuration = arc4random() % 2 +2;
        CGFloat y =  charaImv.frame.origin.y;
        [UIView
         animateWithDuration:rndDuration
         delay:0
         options:UIViewAnimationOptionCurveEaseIn
         animations:^{
             charaImv.frame = CGRectMake(-100 - rndX, y, 60, 60);
         }
         completion:^(BOOL finished){
             
         }];
    }
    restTime = 8;
    gameTimer = [NSTimer
                 scheduledTimerWithTimeInterval:1.0
                 target:self
                 selector:@selector(gameGoing:)
                 userInfo:nil
                 repeats:YES];
    
    [gameTimer fire];
}

- (void)gameGoing:(NSTimer *)timer
{
    restTime = restTime > 0 ? restTime -1 : 0;
    timerLabel.text = [NSString stringWithFormat:@"のこり%d秒", (int)restTime];
    
    if (!restTime) {
        [timer invalidate];
        [self endAction];
        return;
    }
}

- (void)tapAction:(UITapGestureRecognizer*)gesture
{
    if(gesture.view.tag == 101 || gesture.view.tag == 102)
    {
        userCount = gesture.view.tag == 101 ? userCount + 1 : (userCount > 0 ? userCount-1 : 0);
        userCountLabel.text = [NSString stringWithFormat:@"%d", userCount];
        AudioServicesPlaySystemSound(1016);
        return;
    }
    else if(gesture.view.tag == 111)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }

    
}

- (void)endAction
{
    
    UIImageView *resultPopView = [[UIImageView alloc]init];
    resultPopView.backgroundColor = self.view.backgroundColor;
    resultPopView.frame = CGRectMake(0, -self.view.frame.size.height, 320, self.view.frame.size.height);
    resultPopView.userInteractionEnabled = YES;
    [self.view addSubview:resultPopView];
    
    UILabel *resultLabel = [[UILabel alloc]init];
    resultLabel.textColor = [UIColor whiteColor];
    resultLabel.frame = CGRectMake(0, 40, 320, 60);
    resultLabel.font = [UIFont boldSystemFontOfSize:40];
    resultLabel.backgroundColor = [UIColor clearColor];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [resultPopView addSubview:resultLabel];
    int se = 1008;
    if (userCount == amountChara)
    {
        resultLabel.text = @"正解";
        se = 1008;
    }
    else
    {
        resultLabel.text = @"不正解";
        se = 1006;
        
    }
    
    UILabel *descriptLabel = [[UILabel alloc]init];
    descriptLabel.textColor = [UIColor whiteColor];
    descriptLabel.frame = CGRectMake(0, 120, 320, 80);
    descriptLabel.font = [UIFont boldSystemFontOfSize:20];
    descriptLabel.backgroundColor = [UIColor clearColor];
    descriptLabel.textAlignment = NSTextAlignmentCenter;
    descriptLabel.text = [NSString stringWithFormat:@"いまとおりすぎたひよこ：%02d\nあなたのかぞえたひよこ：%02d", amountChara, userCount];
    descriptLabel.numberOfLines = 2;
    [resultPopView addSubview:descriptLabel];
    
    
    UIImageView *backBtn = [[UIImageView alloc]init];
    backBtn.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0];
    backBtn.frame = CGRectMake(60, self.view.frame.size.height -200, 200, 60);
    backBtn.layer.cornerRadius = 10;
    backBtn.clipsToBounds = YES;
    backBtn.tag = 111;
    backBtn.userInteractionEnabled = YES;
    [backBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
    [resultPopView addSubview:backBtn];
    
    UILabel *btnLabel = [[UILabel alloc]init];
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.textColor = [UIColor whiteColor];
    btnLabel.font = [UIFont boldSystemFontOfSize:20];
    btnLabel.frame = CGRectMake(0, 0, 200, 60);
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.text = @"戻る";
    [backBtn addSubview:btnLabel];
    
    CALayer *border = [CALayer layer];
    border.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
    border.frame = CGRectMake(0, 56, 200, 4);
    [backBtn.layer addSublayer:border];
    
    [UIImageView
     animateWithDuration:0.5
     delay:0.5
     options:0
     animations:^{
         resultPopView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
     }
     completion:^(BOOL f){
         AudioServicesPlaySystemSound(se);
     }];
    
    return;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.view.tag > 100 && touch.view.tag < 200)
    {
        touch.view.alpha = 0.5;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unTouchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unTouchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self unTouchesBegan:touches withEvent:event];
}

- (void)unTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.view.tag > 100 && touch.view.tag < 200)
    {
        touch.view.alpha = 1.0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
