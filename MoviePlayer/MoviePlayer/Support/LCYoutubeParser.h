//
//  LCYoutubeParser.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PlayerThumbnailDefault,
    PlayerThumbnailDefaultMedium,
    PlayerThumbnailDefaultHighQuality,
    PlayerThumbnailDefaultMaxQuality
} PlayerThumbnail;


@interface LCYoutubeParser : NSObject

/**
 Method for retrieving the youtube ID from a youtube URL
 
 @param youtubeURL the the complete youtube video url, either youtu.be or youtube.com
 @return string with desired youtube id
 */
+ (NSString *)playerIDFromplayerURL:(NSURL *)playerURL;

/**
 Method for retreiving a iOS supported video link
 
 @param youtubeURL the the complete youtube video url
 @return dictionary with the available formats for the selected video
 
 */
+ (NSDictionary *)h264videosWithplayerURL:(NSURL *)playerURL;

/**
 Method for retreiving an iOS supported video link
 
 @param youtubeID the id of the youtube video
 @return dictionary with the available formats for the selected video
 
 */
+ (NSDictionary *)h264videosWithplayerID:(NSString *)playerID;

/**
 Block based method for retreiving a iOS supported video link
 
 @param youtubeURL the the complete youtube video url
 @param completeBlock the block which is called on completion
 
 */
+ (void)h264videosWithplayerURL:(NSURL *)playerURL
                   completeBlock:(void (^)(NSDictionary *videoDictionary, NSError *error))completeBlock;

/**
 Method for retreiving a thumbnail url for wanted youtube id
 
 @param youtubeURL the complete youtube video id
 @param thumbnailSize the wanted size of the thumbnail
 */
+ (NSURL *)thumbnailUrlForplayerURL:(NSURL *)playerURL
                       thumbnailSize:(PlayerThumbnail)thumbnailSize;

/**
 Method for retreiving a thumbnail for wanted youtube url
 
 @param youtubeURL the the complete youtube video url
 @param thumbnailSize the wanted size of the thumbnail
 @param completeBlock the block which is called on completion
 */
+ (void)thumbnailForplayerURL:(NSURL *)playerURL
                 thumbnailSize:(PlayerThumbnail)thumbnailSize
                 completeBlock:(void (^)(UIImage *image, NSError *error))completeBlock;

/**
 Method for retreiving a thumbnail for wanted youtube id
 
 @param youtubeURL the complete youtube video id
 @param thumbnailSize the wanted size of the thumbnail
 @param completeBlock the block which is called on completion
 */
+ (void)thumbnailForplayerID:(NSString *)playerID
                thumbnailSize:(PlayerThumbnail)thumbnailSize
                completeBlock:(void (^)(UIImage *image, NSError *error))completeBlock;


/**
 Method for retreiving all the details of a youtube video
 
 @param youtubeURL the the complete youtube video url
 @param completeBlock the block which is called on completion
 
 */
+ (void)detailsForplayerURL:(NSURL *)playerURL
               completeBlock:(void (^)(NSDictionary *details, NSError *error))completeBlock;
@end
