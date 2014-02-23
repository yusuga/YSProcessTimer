//
//  YSProcessTimer.h
//  YSProcessTimeExample
//
//  Created by Yu Sugawara on 2014/02/21.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSProcessTimer : NSObject

- (instancetype)initWithProcessName:(NSString*)processName;

- (void)start;
- (NSTimeInterval)currentRapTime;
- (void)addRapWithComment:(NSString *)comment;
- (void)stop;

@end
