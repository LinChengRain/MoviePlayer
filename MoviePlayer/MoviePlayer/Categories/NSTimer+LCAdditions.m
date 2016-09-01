//
//  NSTimer+LCAdditions.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "NSTimer+LCAdditions.h"

@implementation NSTimer (LCAdditions)

+ (void)executeTimerBlock:(NSTimer *)timer {
    
}

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval firing:(TimerFireBlock)fireBlock
{
    
    return [self scheduledTimerWithTimeInterval:inTimeInterval firing:fireBlock];
}
+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeating:(BOOL)repeat firing:(TimerFireBlock)fireBlock
{
    id block = [fireBlock copy];
    
    return [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeTimerBlock:) userInfo:block repeats:repeat];
}

@end
