//
//  GameViewController.h
//  hackathon1
//
//  Created by kixixixixi on 2014/05/22.
//  Copyright (c) 2014年 kixixixixi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
{
    NSTimer *gameTimer;
    NSTimer *startTimer;
    NSMutableArray *charaImvArray;
    NSInteger userCount;
    
    UILabel *userCountLabel;
    UILabel *timerLabel;
    
    NSInteger restTime;
    
    NSInteger amountChara;
}

@property (readwrite) NSInteger maxAmount;

@end
