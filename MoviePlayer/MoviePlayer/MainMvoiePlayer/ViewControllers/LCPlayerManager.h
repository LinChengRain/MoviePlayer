//
//  LCPlayerManager.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPlayerManager : NSObject


- (id) initWithURL:(NSURL *)assetURL;

@property (strong, nonatomic, readonly) UIView *view;


@end
