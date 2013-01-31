//
//  ContainerController.h
//  TransitionTest
//
//  Created by Joseph Lin on 10/31/11.
//  Copyright (c) 2011 Joseph Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContainerController : UIViewController

+ (ContainerController*)containerController;
- (UIViewController *)topViewController;

- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController*)popControllerAnimated:(BOOL)animated;


@end
