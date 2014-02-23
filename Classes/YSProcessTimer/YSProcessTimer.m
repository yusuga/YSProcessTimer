//
//  YSProcessTimer.m
//  YSProcessTimeExample
//
//  Created by Yu Sugawara on 2014/02/21.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "YSProcessTimer.h"

#define LOG_PROCESS_TIME(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface YSProcessTimerRap : NSObject

@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *comment;

@end

@implementation YSProcessTimerRap

@end

@interface YSProcessTimer ()

@property (nonatomic) NSString *processName;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSMutableArray *raps;

@end

@implementation YSProcessTimer

- (instancetype)initWithProcessName:(NSString*)processName
{
    if (self = [super init]) {
        self.processName = processName;
    }
    return self;
}

- (void)start
{
    NSLog(@"Start %@", self.processName);
    self.raps = [NSMutableArray array];
    self.startDate = [NSDate dateWithTimeIntervalSinceNow:0.];
}

- (NSTimeInterval)currentRapTime
{
    if (!self.startDate) {
        NSLog(@"Not start.");
    }
    return [[NSDate dateWithTimeIntervalSinceNow:0.] timeIntervalSinceDate:self.startDate];
}

- (void)addRapWithComment:(NSString *)comment
{
    YSProcessTimerRap *rap = [[YSProcessTimerRap alloc] init];
    rap.date = [NSDate dateWithTimeIntervalSinceNow:0.];
    rap.comment = comment;
    [self.raps addObject:rap];
}

- (void)stop
{
    if (!self.startDate) {
        NSLog(@"Not start.");
        return;
    }
    
    NSDate *stopDate = [NSDate dateWithTimeIntervalSinceNow:0.];
    
    void(^addSeparator)(NSMutableString *str, NSUInteger length) = ^(NSMutableString *str, NSUInteger lenght) {
        for (int i = 0; i < lenght; i++) {
            [str appendString:@"="];
        }
        [str appendString:@"\n"];
    };
    NSString *allProcessTimeStr = @"All process time:";
    NSMutableString *desc = [NSMutableString stringWithFormat:@"Stop\n\n"];
    NSUInteger separatorLen = self.processName ? self.processName.length + 4 : 10;
    addSeparator(desc, separatorLen);
    if (self.processName) {
        [desc appendFormat:@"= %@ =\n", self.processName];
        addSeparator(desc, separatorLen);
    }
    [self.raps enumerateObjectsUsingBlock:^(YSProcessTimerRap *rap, NSUInteger idx, BOOL *stop) {
        NSString *rapDesc = [NSString stringWithFormat:@"rap%@", @(idx+1)];
        [desc appendString:rapDesc];
        for (int i = 0; i < allProcessTimeStr.length - rapDesc.length - 1; i++) {
            [desc appendString:@" "];
        }
        [desc appendString:@":"];
        [desc appendFormat:@"%14f", [rap.date timeIntervalSinceDate:self.startDate]];
        if (rap.comment) {
            [desc appendFormat:@" (%@)", rap.comment];
        }
        [desc appendString:@"\n"];
    }];
    [desc appendFormat:@"%@%14f\n", allProcessTimeStr, [stopDate timeIntervalSinceDate:self.startDate]];
    addSeparator(desc, separatorLen);
    [desc appendString:@"\n"];

    NSLog(@"%@", desc);
}

@end
