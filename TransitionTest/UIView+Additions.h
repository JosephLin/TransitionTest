//
//  untitled.h
//  NikeTraining
//
//  Created by Niall McCormack on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView(Additions)

- (void)setOrigin:(CGPoint)point;
- (void)setSize:(CGSize)size;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)sizeToFitWidth;
- (void)sizeToFitHeight;
- (UIImage *)renderToImage;

@end
