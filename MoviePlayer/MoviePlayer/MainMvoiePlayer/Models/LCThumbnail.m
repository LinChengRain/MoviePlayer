//
//  LCThumbnail.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "LCThumbnail.h"

@implementation LCThumbnail

+ (instancetype)thumbnailWithImage:(UIImage *)image time:(CMTime)time
{
    return [[self alloc] initWithImage:image time:time];
}

- (id)initWithImage:(UIImage *)image time:(CMTime)time
{
    self = [super init];
    
    if (self) {
        _image = image;
        _time = time;
    }
    return self;
}
@end
