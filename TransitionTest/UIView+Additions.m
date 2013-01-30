//
//  UIView+Additions.m
//  NikeTraining
//
//  Created by Niall McCormack on 2/22/11.
//  Copyright 2011 R/GA. All rights reserved.
//

#import "UIView+Additions.h"


@implementation UIView(Additions)

- (void)setOrigin:(CGPoint)point
{
	CGRect currentFrame = self.frame;
	currentFrame.origin = point;
	self.frame = currentFrame;
}

- (void)setSize:(CGSize)size
{
	CGRect currentFrame = self.frame;
	currentFrame.size = size;
	self.frame = currentFrame;
}

- (void)setX:(CGFloat)x
{
	CGRect rect = self.frame;
	rect.origin.x = x;
	self.frame = rect;    
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
	rect.origin.y = y;
	self.frame = rect;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
	rect.size.width = width;
	self.frame = rect;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
	rect.size.height = height;
	self.frame = rect;
}

- (void)sizeToFitWidth
{
    CGSize size = [self sizeThatFits:self.frame.size];
    [self setWidth:size.width];
}

- (void)sizeToFitHeight
{
    CGSize size = [self sizeThatFits:self.frame.size];
    [self setHeight:size.height];
}

- (UIImage *)renderToImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
