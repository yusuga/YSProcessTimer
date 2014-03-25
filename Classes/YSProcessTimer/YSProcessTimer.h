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
@property (nonatomic, copy) NSString *processName;

- (void)startWithComment:(NSString*)comment;
- (NSTimeInterval)currentRapTime;
- (void)addRapWithComment:(NSString *)comment;
- (void)stopWithComment:(NSString*)stopComment;

- (void)startAverageTime;
- (void)stopAverageTime;
- (NSTimeInterval)averageTime;

@end
