//
//  AppDelegate.m
//  TransitionTest
//
//  Created by Joseph Lin on 1/30/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "UIBarButtonItem+AppAppearance.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [UIBarButtonItem setAppBackground];
    [UIBarButtonItem setAppFont];    

    return YES;
}

@end
