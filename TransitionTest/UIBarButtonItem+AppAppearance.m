//
//  UIBarButtonItem+AppAppearance.m
//  TransitionTest
//
//  Created by Joseph Lin on 2/19/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "UIBarButtonItem+AppAppearance.h"

@implementation UIBarButtonItem (AppAppearance)

- (void)setAppBackground
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"navButtonBlank"];
    blackButtonImage = [blackButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 15, 15)];
    [self setBackgroundImage:blackButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)setAppFont
{
    [self setTitleTextAttributes:@{
             UITextAttributeFont:[UIFont systemFontOfSize:12.0],
        UITextAttributeTextColor:[UIColor lightGrayColor]}
                        forState:UIControlStateNormal];
}

+ (void)setAppBackground
{
    UIImage *blackButtonImage = [UIImage imageNamed:@"navButtonBlank"];
    blackButtonImage = [blackButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 15, 15)];
    [[UIBarButtonItem appearance] setBackgroundImage:blackButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

+ (void)setAppFont
{
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                     UITextAttributeFont:[UIFont systemFontOfSize:12.0],
                                UITextAttributeTextColor:[UIColor lightGrayColor]}
                                                forState:UIControlStateNormal];
}


@end
