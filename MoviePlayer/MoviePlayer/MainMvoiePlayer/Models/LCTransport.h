//
//  LCTransport.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@protocol LCTransportDelegate <NSObject>

- (void)play;
- (void)pause;
- (void)stop;

- (void)scrubbingDidStart;
- (void)scrubbedToTime:(NSTimeInterval)time;
- (void)scrubbingDidEnd;

- (void)jumpedToTime:(NSTimeInterval)time;

@optional
- (void)subtitleSelected:(NSString *)subtitle;

@end

@protocol LCTransport <NSObject>

@property (weak, nonatomic) id <LCTransportDelegate> delegate;

- (void)setTitle:(NSString *)title;
- (void)setCurrentTime:(NSTimeInterval)time duration:(NSTimeInterval)duration;
- (void)setScrubbingTime:(NSTimeInterval)time;
- (void)playbackComplete;
- (void)setSubtitles:(NSArray *)subtitles;

@end