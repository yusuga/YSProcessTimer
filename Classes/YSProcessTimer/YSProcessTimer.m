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

@property (nonatomic) YSProcessTimerRap *startTime;
@property (nonatomic) NSMutableArray *raps;

@end

@implementation YSProcessTimer

+ (instancetype)sharedInstance
{
#if kYSProcessTimerInvalid
    return nil;
#endif
    
    static id s_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance =  [[self alloc] init];
    });
    return s_sharedInstance;
}

- (instancetype)initWithProcessName:(NSString*)processName
{
#if kYSProcessTimerInvalid
    return nil;
#endif
    
    if (self = [super init]) {
        self.processName = processName;
    }
    return self;
}

- (void)startWithComment:(NSString*)comment
{
    NSLog(@"Start %@", self.processName ? self.processName : nil);
    self.raps = [NSMutableArray array];

    YSProcessTimerRap *startTime = [[YSProcessTimerRap alloc] init];
    startTime.date = [NSDate dateWithTimeIntervalSinceNow:0.];
    startTime.comment = comment;
    self.startTime = startTime;
}

- (NSTimeInterval)currentRapTime
{
    if (!self.startTime.date) {
        NSLog(@"Not start.");
    }
    return [[NSDate dateWithTimeIntervalSinceNow:0.] timeIntervalSinceDate:self.startTime.date];
}

- (void)addRapWithComment:(NSString *)comment
{
    YSProcessTimerRap *rap = [[YSProcessTimerRap alloc] init];
    rap.date = [NSDate dateWithTimeIntervalSinceNow:0.];
    rap.comment = comment;
    [self.raps addObject:rap];
}

- (void)stopWithComment:(NSString*)stopComment
{
    if (!self.startTime.date) {
        NSLog(@"Not start.");
        return;
    }
    
    NSDate *stopDate = [NSDate dateWithTimeIntervalSinceNow:0.];
    
    NSString*(^stringToFill)(NSString *charToFill, NSUInteger length) = ^NSString*(NSString *charToFill, NSUInteger lenght) {
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < lenght; i++) {
            [str appendString:charToFill];
        }
        return str;
    };
    
    NSMutableString *desc = [NSMutableString stringWithString:@"\n\n"];
    
    NSUInteger separatorLen = self.processName ? self.processName.length + 4 : 10;
    [desc appendFormat:@"%@\n", stringToFill(@"=", separatorLen)];
    if (self.processName) {
        [desc appendFormat:@"= %@ =\n", self.processName];
        [desc appendFormat:@"%@\n", stringToFill(@"=", separatorLen)];
    }
    NSUInteger leftColumnLen = 10;
    NSString *startStr = @"Start";
    [desc appendFormat:@"%@%@:%14f", startStr, stringToFill(@" ", leftColumnLen - startStr.length), 0.];
    if (self.startTime.comment) {
        [desc appendFormat:@" ( %f) %@", 0., self.startTime.comment];
    }
    [desc appendString:@"\n"];
    
    __block NSDate *beforeDate = self.startTime.date;
    [self.raps enumerateObjectsUsingBlock:^(YSProcessTimerRap *rap, NSUInteger idx, BOOL *stop) {
        NSString *rapStr = [NSString stringWithFormat:@"rap%@", @(idx+1)];
        [desc appendFormat:@"rap%@%@:%14f (+%f) %@\n",
         @(idx + 1),
         stringToFill(@" ", leftColumnLen - rapStr.length),
         [rap.date timeIntervalSinceDate:self.startTime.date],
         [rap.date timeIntervalSinceDate:beforeDate],
         rap.comment ? rap.comment : nil];
        beforeDate = rap.date;
    }];
    NSString *stopStr = @"Stop";
    [desc appendFormat:@"%@%@:%14f (+%f)",
     stopStr,
     stringToFill(@" ", leftColumnLen - stopStr.length),
     [stopDate timeIntervalSinceDate:self.startTime.date],
     [stopDate timeIntervalSinceDate:beforeDate]];
    if (stopComment) {
        [desc appendFormat:@" %@", stopComment];
    }
    [desc appendString:@"\n"];
    
    [desc appendFormat:@"%@\n\n", stringToFill(@"=", separatorLen)];

    NSLog(@"%@", desc);
    
    self.startTime = nil;
    [self.raps removeAllObjects];
}

@end
