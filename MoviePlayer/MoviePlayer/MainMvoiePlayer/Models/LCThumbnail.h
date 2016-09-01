//
//  LCThumbnail.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

@interface LCThumbnail : NSObject

+ (instancetype)thumbnailWithImage:(UIImage *)image time:(CMTime)time;

@property (nonatomic, readonly) CMTime time;
@property (strong, nonatomic, readonly) UIImage *image;

@end
