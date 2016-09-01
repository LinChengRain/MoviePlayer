//
//  LCPlayerView.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "LCTransport.h"
#import <UIKit/UIKit.h>

@class AVPlayer;
@interface LCPlayerView : UIView

- (id)initWithPlayer:(AVPlayer *)player;

@property (nonatomic, readonly) id <LCTransport> transport;
@end
