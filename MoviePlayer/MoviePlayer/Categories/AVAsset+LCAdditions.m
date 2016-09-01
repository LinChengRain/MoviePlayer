//
//  AVAsset+LCAdditions.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "AVAsset+LCAdditions.h"

@implementation AVAsset (LCAdditions)

- (NSString *)title {
    
    AVKeyValueStatus status = [self statusOfValueForKey:@"commonMetadata" error:nil];
    if (status == AVKeyValueStatusLoaded)
    {
        NSArray *items =
        [AVMetadataItem metadataItemsFromArray:self.commonMetadata
                                       withKey:AVMetadataCommonKeyTitle
                                      keySpace:AVMetadataKeySpaceCommon];
        if (items.count > 0)
        {
            AVMetadataItem *titleItem = [items firstObject];
            return (NSString *)titleItem.value;
        }
    }
    
    return nil;
}
@end
