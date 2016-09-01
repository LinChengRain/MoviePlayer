//
//  LCYoutubeParser.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "LCYoutubeParser.h"

#define kYoutubeInfoURL      @"http://www.youtube.com/get_video_info?video_id="
#define kYoutubeThumbnailURL @"http://img.youtube.com/vi/%@/%@.jpg"
#define kYoutubeDataURL      @"http://gdata.youtube.com/feeds/api/videos/%@?alt=json"
#define kUserAgent @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4"


@interface NSString (QueryString)

/**
 Parses a query string
 @return key value dictionary with each parameter as an array
 */
- (NSMutableDictionary *)dictionaryFromQueryStringComponents;


/**
 Convenient method for decoding a html encoded string
 */
- (NSString *)stringByDecodingURLFormat;

@end

@interface NSURL (QueryString)

/**
 Parses a query string of an NSURL
 @return key value dictionary with each parameter as an array
 */
- (NSMutableDictionary *)dictionaryForQueryString;

@end
@implementation NSString (QueryString)

- (NSString *)stringByDecodingURLFormat {
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSMutableDictionary *)dictionaryFromQueryStringComponents {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    for (NSString *keyValue in [self componentsSeparatedByString:@"&"]) {
        NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
        if ([keyValueArray count] < 2) {
            continue;
        }
        
        NSString *key = [[keyValueArray objectAtIndex:0] stringByDecodingURLFormat];
        NSString *value = [[keyValueArray objectAtIndex:1] stringByDecodingURLFormat];
        
        NSMutableArray *results = [parameters objectForKey:key];
        
        if (!results) {
            results = [NSMutableArray arrayWithCapacity:1];
            [parameters setObject:results forKey:key];
        }
        
        [results addObject:value];
    }
    
    return parameters;
}

@end

@implementation NSURL (QueryString)

- (NSMutableDictionary *)dictionaryForQueryString {
    return [[self query] dictionaryFromQueryStringComponents];
}

@end

@implementation LCYoutubeParser

+ (NSString *)playerIDFromplayerURL:(NSURL *)playerURL
{
    NSString *playerID = nil;
    if ([playerURL.host isEqualToString:@"youtu.be"]) {
        playerID = [[playerURL pathComponents]objectAtIndex:1];
        
    }else if ([playerURL.absoluteString rangeOfString:@"www.youtube.com/embed"].location != NSNotFound) {
        playerID = [[playerURL pathComponents] objectAtIndex:2];
    } else {
        playerID = [[[playerURL dictionaryForQueryString] objectForKey:@"v"] objectAtIndex:0];
    }
    
    return playerID;

}

+ (NSDictionary *)h264videosWithplayerID:(NSString *)playerID
{

    if (playerID) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kYoutubeInfoURL, playerID]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
        [request setHTTPMethod:@"GET"];
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (!error) {
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            NSMutableDictionary *parts = [responseString dictionaryFromQueryStringComponents];
            
            if (parts) {
                
                NSString *fmtStreamMapString = [[parts objectForKey:@"url_encoded_fmt_stream_map"]objectAtIndex:0];
                NSArray *fmtStreamMapArray = [fmtStreamMapString componentsSeparatedByString:@","];
                
                NSMutableDictionary *videoDictionary = [NSMutableDictionary dictionary];
                
                for (NSString *videoEncodedString in fmtStreamMapArray) {
                    NSMutableDictionary *videoComponents = [videoEncodedString dictionaryFromQueryStringComponents];
                    NSString *type = [[[videoComponents objectForKey:@"type"] objectAtIndex:0] stringByDecodingURLFormat];
                    NSString *signature = nil;
                    
                    if (![videoComponents objectForKey:@"stereo3d"]) {
                        if ([videoComponents objectForKey:@"sig"]) {
                            signature = [[videoComponents objectForKey:@"sig"] objectAtIndex:0];
                        }
                        
                        if (signature && [type rangeOfString:@"mp4"].length > 0) {
                            NSString *url = [[[videoComponents objectForKey:@"url"] objectAtIndex:0] stringByDecodingURLFormat];
                            url = [NSString stringWithFormat:@"%@&signature=%@", url, signature];
                            
                            NSString *quality = [[[videoComponents objectForKey:@"quality"] objectAtIndex:0] stringByDecodingURLFormat];
                            if ([videoDictionary valueForKey:quality] == nil) {
                                [videoDictionary setObject:url forKey:quality];
                            }
                        }
                    }
                }
                
                return videoDictionary;
            }
        }
    }

    return nil;
}

+ (NSDictionary *)h264videosWithplayerURL:(NSURL *)playerURL
{
    NSString *playerID = [self playerIDFromplayerURL:playerURL];
    
    return [self h264videosWithplayerID:playerID];
}

+ (void)h264videosWithplayerURL:(NSURL *)playerURL completeBlock:(void (^)(NSDictionary *, NSError *))completeBlock
{
    NSString *playerID = [self playerIDFromplayerURL:playerURL];
    
    if (playerID) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kYoutubeInfoURL, playerID]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
        [request setHTTPMethod:@"GET"];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSMutableDictionary *parts = [responseString dictionaryFromQueryStringComponents];
                
                if (parts) {
                    
                    NSString *fmtStreamMapString = [[parts objectForKey:@"url_encoded_fmt_stream_map"] objectAtIndex:0];
                    NSArray *fmtStreamMapArray = [fmtStreamMapString componentsSeparatedByString:@","];
                    
                    NSMutableDictionary *videoDictionary = [NSMutableDictionary dictionary];
                    
                    for (NSString *videoEncodedString in fmtStreamMapArray) {
                        NSMutableDictionary *videoComponents = [videoEncodedString dictionaryFromQueryStringComponents];
                        NSString *type = [[[videoComponents objectForKey:@"type"] objectAtIndex:0] stringByDecodingURLFormat];
                        NSString *signature = nil;
                        if ([videoComponents objectForKey:@"sig"]) {
                            signature = [[videoComponents objectForKey:@"sig"] objectAtIndex:0];
                        }
                        
                        if ([type rangeOfString:@"mp4"].length > 0) {
                            NSString *url = [[[videoComponents objectForKey:@"url"] objectAtIndex:0] stringByDecodingURLFormat];
                            url = [NSString stringWithFormat:@"%@&signature=%@", url, signature];
                            
                            NSString *quality = [[[videoComponents objectForKey:@"quality"] objectAtIndex:0] stringByDecodingURLFormat];
                            
                            if ([videoDictionary valueForKey:quality] == nil) {
                                [videoDictionary setObject:url forKey:quality];
                            }
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(videoDictionary, nil);
                    });
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(nil, error);
                });
            }
        }];
    }

}

+ (void)thumbnailForplayerURL:(NSURL *)playerURL thumbnailSize:(PlayerThumbnail)thumbnailSize completeBlock:(void (^)(UIImage *, NSError *))completeBlock
{
    NSString *playerID = [self playerIDFromplayerURL:playerURL];
    
    return [self thumbnailForplayerID:playerID thumbnailSize:thumbnailSize completeBlock:completeBlock];

}
+ (NSURL *)thumbnailUrlForplayerURL:(NSURL *)playerURL thumbnailSize:(PlayerThumbnail)thumbnailSize
{
    NSURL *url = nil;
    
    if (playerURL) {
        
        NSString *thumbnailSizeString = nil;
        switch (thumbnailSize) {
            case PlayerThumbnailDefault:
                thumbnailSizeString = @"default";
                break;
            case PlayerThumbnailDefaultMedium:
                thumbnailSizeString = @"mqdefault";
                break;
            case PlayerThumbnailDefaultHighQuality:
                thumbnailSizeString = @"hqdefault";
                break;
            case PlayerThumbnailDefaultMaxQuality:
                thumbnailSizeString = @"maxresdefault";
                break;
            default:
                thumbnailSizeString = @"default";
                break;
        }
        
        NSString *youtubeID = [self playerIDFromplayerURL:playerURL];
        
        url = [NSURL URLWithString:[NSString stringWithFormat:kYoutubeThumbnailURL, youtubeID, thumbnailSizeString]];
        
    }
    
    return url;
}

+ (void)thumbnailForplayerID:(NSString *)playerID thumbnailSize:(PlayerThumbnail)thumbnailSize completeBlock:(void (^)(UIImage *, NSError *))completeBlock
{
    if (playerID) {
        
        NSString *thumbnailSizeString = nil;
        switch (thumbnailSize) {
            case PlayerThumbnailDefault:
                thumbnailSizeString = @"default";
                break;
            case PlayerThumbnailDefaultMedium:
                thumbnailSizeString = @"mqdefault";
                break;
            case PlayerThumbnailDefaultHighQuality:
                thumbnailSizeString = @"hqdefault";
                break;
            case PlayerThumbnailDefaultMaxQuality:
                thumbnailSizeString = @"maxresdefault";
                break;
            default:
                thumbnailSizeString = @"default";
                break;
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kYoutubeThumbnailURL, playerID, thumbnailSizeString]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
        [request setHTTPMethod:@"GET"];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                completeBlock(image, nil);
            }
            else {
                completeBlock(nil, error);
            }
        }];
        
    }
    else {
        
        NSDictionary *details = @{NSLocalizedDescriptionKey : @"Could not find a valid Youtube ID"};
        
        NSError *error = [NSError errorWithDomain:@"com.hiddencode.yt-parser" code:0 userInfo:details];
        
        completeBlock(nil, error);
    }
}

+ (void)detailsForplayerURL:(NSURL *)playerURL completeBlock:(void (^)(NSDictionary *, NSError *))completeBlock
{

    NSString *playerID = [self playerIDFromplayerURL:playerURL];
    if (playerID) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:kYoutubeDataURL, playerID]]];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                if (!error) {
                    completeBlock(json, nil);
                }
                else {
                    completeBlock(nil, error);
                }
            }
            else {
                completeBlock(nil, error);
            }
        }];
    }
    else {
        NSDictionary *details = @{NSLocalizedDescriptionKey : @"Could not find a valid Youtube ID"};
        
        NSError *error = [NSError errorWithDomain:@"com.hiddencode.yt-parser" code:0 userInfo:details];
        
        completeBlock(nil, error);
    }
}
@end
