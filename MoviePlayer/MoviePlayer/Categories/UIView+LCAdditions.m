//
//  UIView+LCAdditions.m
//  MoviePlayer
//
//  Created by qunqu on 16/9/1.
//  Copyright © 2016年 YuChanglin. All rights reserved.
//

#import "UIView+LCAdditions.h"

@implementation UIView (LCAdditions)

// x
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}
//y
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

//centerX
- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerX{
    return self.center.x;
}
//centerY
- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)centerY{
    return self.center.y;
}
//  Size.
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGPoint)frameOrigin
{
    return self.frame.origin;
}


- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    CGRect frame = self.frame;
    frame.origin = frameOrigin;
    self.frame = frame;
}


- (CGFloat)frameBottom
{
    return self.frameTop + self.height;
}


- (void)setFrameBottom:(CGFloat)frameBottom
{
    self.frameTop = frameBottom - self.height;
}


- (CGFloat)frameLeft
{
    return self.frameOrigin.x;
}


- (void)setFrameLeft:(CGFloat)frameLeft
{
    self.frameOrigin = CGPointMake(frameLeft, self.frameTop);
}


- (CGFloat)frameRight
{
    return self.frameLeft + self.width;
}


- (void)setFrameRight:(CGFloat)frameRight
{
    self.frameLeft = frameRight - self.width;
}


- (CGFloat)frameTop
{
    return self.frameOrigin.y;
}


- (void)setFrameTop:(CGFloat)frameTop
{
    self.frameOrigin = CGPointMake(self.frameLeft, frameTop);
}

- (CGFloat)boundsX {
    return self.bounds.origin.x;
}

- (void)setBoundsX:(CGFloat)newX {
    self.bounds = CGRectMake(newX, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)boundsY {
    return self.bounds.origin.y;
}

- (void)setBoundsY:(CGFloat)newY {
    self.bounds = CGRectMake(self.bounds.origin.x, newY, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)boundsWidth {
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)newWidth {
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, newWidth, self.bounds.size.height);
}

- (CGFloat)boundsHeight {
    return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)newHeight {
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, newHeight);
}

#pragma mark -
- (UIImage *)toImage {
    return [self toImageWithSize:self.bounds.size];
}


- (UIImage *)toImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImageView *)toImageView
{
    return [self toImageViewWithSize:self.bounds.size];
}

- (UIImageView *)toImageViewWithSize:(CGSize)size
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self toImageWithSize:size]];
    imageView.frame = CGRectMake(self.x, self.y, size.width, size.height);
    return imageView;
}
@end
