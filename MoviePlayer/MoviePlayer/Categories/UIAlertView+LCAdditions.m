//
//  UIAlertView+LCAdditions.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "UIAlertView+LCAdditions.h"

@implementation UIAlertView (LCAdditions)

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

@end
