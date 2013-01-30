//
//  ContainerController.h
//  NikeBasketball
//
//  Created by Rob Seward on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContainerController : UIViewController <UITabBarDelegate>

@property (nonatomic, strong) IBOutlet UITabBar *tabBar;
@property (nonatomic, strong) IBOutlet UIView *contentArea;
@property (nonatomic, strong) NSArray *stacks;
@property (nonatomic) BOOL showingTabBar;
@property (nonatomic) NSInteger currentTabBarSelection;

+ (ContainerController*)containerController;
- (UIViewController *)topController;

- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)replaceController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController*)popControllerAnimated:(BOOL)animated;

- (void)pushOverlay:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)popOverlayAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)hideTabBar;
- (void)showTabBar;

@end
