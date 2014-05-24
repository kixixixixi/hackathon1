//
//  TopViewController.m
//  hackathon1
//
//  Created by kixixixixi on 2014/05/22.
//  Copyright (c) 2014年 kixixixixi. All rights reserved.
//

#import "TopViewController.h"

@interface TopViewController ()

@end

@implementation TopViewController

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
    
    UILabel *logoLabel = [[UILabel alloc]init];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.font = [UIFont boldSystemFontOfSize:36];
    logoLabel.text = @"ひよこゲーム";
    logoLabel.textColor = [UIColor whiteColor];
    logoLabel.frame = CGRectMake(20, 20, 280, 40);
    [self.view addSubview:logoLabel];
    
    
    UIImageView *logoImv = [[UIImageView alloc]init];
    logoImv.image = [UIImage imageNamed:@"hiyo.png"];
    logoImv.frame = CGRectMake(100, 80 + iPhone5headSpace, 120, 120);
    [self.view addSubview:logoImv];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *startBtn = [[UIImageView alloc]init];
        startBtn.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0];
        startBtn.frame = CGRectMake(60, 240 +iPhone5headSpace +80*i, 200, 60);
        startBtn.layer.cornerRadius = 10;
        startBtn.clipsToBounds = YES;
        
        CALayer *border = [CALayer layer];
        border.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
        border.frame = CGRectMake(0, 56, 200, 4);
        [startBtn.layer addSublayer:border];
        
        startBtn.tag = 101 +i;
        startBtn.userInteractionEnabled = YES;
        [startBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
        [self.view addSubview:startBtn];
        
        UILabel *btnLabel = [[UILabel alloc]init];
        btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.textColor = [UIColor whiteColor];
        btnLabel.font = [UIFont boldSystemFontOfSize:20];
        btnLabel.frame = CGRectMake(0, 0, 200, 60);
        btnLabel.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                btnLabel.text = @"かんたん";
                break;
            case 1:
                btnLabel.text = @"ふつう";
                break;
            case 2:
                btnLabel.text = @"むずかし";
                break;

        }
        [startBtn addSubview:btnLabel];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    if (gesture.view.tag == 101 || gesture.view.tag == 102 || gesture.view.tag == 103) {
        GameViewController *gameViewCtr = [[GameViewController alloc]init];
        
        switch (gesture.view.tag) {
            case 101:
                gameViewCtr.maxAmount = 10;
                break;
            case 102:
                gameViewCtr.maxAmount = 20;
                break;
            case 103:
                gameViewCtr.maxAmount = 30;
                break;
                
        }
        
        [self.navigationController pushViewController:gameViewCtr animated:YES];
        AudioServicesPlaySystemSound(1013);
        return;
    }
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
