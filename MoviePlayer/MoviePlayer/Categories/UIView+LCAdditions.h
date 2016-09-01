//
//  UIView+LCAdditions.h
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCAdditions)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

//  Size.
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//  Origin.
@property (assign, nonatomic) CGPoint frameOrigin;
@property (assign, nonatomic) CGFloat frameBottom;
@property (assign, nonatomic) CGFloat frameLeft;
@property (assign, nonatomic) CGFloat frameRight;
@property (assign, nonatomic) CGFloat frameTop;

@property (nonatomic, assign) CGFloat boundsX;
@property (nonatomic, assign) CGFloat boundsY;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;


/**
 * Returns the UIImage representation of this view.
 */
- (UIImage *)toImage;

/**
 * Returns a UIImageView representation of this view.  The image view's initial frame
 * is set to the frame as the view.
 */
- (UIImageView *)toImageView;

@end
