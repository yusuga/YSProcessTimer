//
//  ViewController.m
//  YSProcessTimerExample
//
//  Created by Yu Sugawara on 2014/02/23.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "ViewController.h"
#import "YSProcessTimer.h"

@interface ViewController ()

@property (nonatomic) YSProcessTimer *timer;

@end

@implementation ViewController

- (void)awakeFromNib
{
    YSProcessTimer *timer = [[YSProcessTimer alloc] initWithProcessName:@"UIViewController lifecycle"];
    [timer startWithComment:[NSString stringWithFormat:@"%s", __func__]];
    self.timer = timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.timer addRapWithComment:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.timer addRapWithComment:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewWillLayoutSubviews
{
    [self.timer addRapWithComment:[NSString stringWithFormat:@"%s", __func__]];
    NSLog(@"current rap time %@", @([self.timer currentRapTime]));
}

- (void)viewDidLayoutSubviews
{
    [self.timer addRapWithComment:[NSString stringWithFormat:@"%s", __func__]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    [self.timer stopWithComment:[NSString stringWithFormat:@"%s", __func__]];
    
    [self testAverage];
    [self testSimpleTimer];
}

- (void)testAverage
{
    YSProcessTimer *timer = [[YSProcessTimer alloc] initWithProcessName:@"Test averrage"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 50; i++) {
            [timer startAverageTime];
            [NSThread sleepForTimeInterval:0.1];
            [timer stopAverageTime];
        }
        [timer averageTime];
    });
}

- (void)testSimpleTimer
{
    [YSProcessTimer startWithProcessName:@"Test simple timer" process:^{
        [NSThread sleepForTimeInterval:1.];
    }];
    
    [YSProcessTimer startAverageWithProcessName:@"Test simple sverage timer" numberOfTrials:10 process:^{
        [NSThread sleepForTimeInterval:0.1];
    }];
}

@end
