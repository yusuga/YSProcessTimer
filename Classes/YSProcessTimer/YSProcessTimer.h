//
//  YSProcessTimer.h
//  YSProcessTimeExample
//
//  Created by Yu Sugawara on 2014/02/21.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DEBUG
    #define kYSProcessTimerInvalid 1
#endif

@interface YSProcessTimer : NSObject

+ (instancetype)sharedInstance;
- (instancetype)initWithProcessName:(NSString*)processName;
@property (nonatomic) NSString *processName;

- (void)start;
- (NSTimeInterval)currentRapTime;
- (void)addRapWithComment:(NSString *)comment;
- (void)stop;

@end
