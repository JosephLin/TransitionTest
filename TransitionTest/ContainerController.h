//
//  ContainerController.h
//  NikeBasketball
//
//  Created by Rob Seward on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContainerController : UIViewController <UITabBarDelegate>

+ (ContainerController*)containerController;
- (UIViewController *)topViewController;

- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController*)popControllerAnimated:(BOOL)animated;


@end
