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
    [timer start];
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
    [self.timer addRapWithComment:[NSString stringWithFormat:@"%s", __func__]];
    
    [self.timer stop];
}

@end
