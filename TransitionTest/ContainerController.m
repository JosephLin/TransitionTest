//
//  ContainerController.m
//  NikeBasketball
//
//  Created by Rob Seward on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ContainerController.h"
#import "MasterViewController.h"
#import "UIView+Additions.h"

typedef NS_ENUM(NSUInteger, TabBarIndex) {
    TabBarIndexHome = 0,
    TabBarIndexActivity,
    TabBarIndexRankings,
    TabBarIndexFriends,
    TabBarIndexMore,
};



@interface ContainerController ()
@property (nonatomic, strong, readonly) NSMutableArray* selectedStack;
@property (nonatomic) UIInterfaceOrientation currentOrientation;
@property (nonatomic) BOOL tabSwitching;
@property (nonatomic) BOOL inTransition;
@end



@implementation ContainerController


#pragma mark - shortcut

+ (ContainerController*)containerController
{
    return (ContainerController*)((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
}

- (UIViewController *)topController
{
    return [self.selectedStack lastObject];
}

- (NSMutableArray *)selectedStack
{
    return [self.stacks objectAtIndex:self.currentTabBarSelection];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = YES;
    self.contentArea.autoresizesSubviews = YES;

    [self setupTabBar];
    self.showingTabBar = YES;
}


#pragma mark - Push

- (void)pushController:(UIViewController *)toViewController withTransitionType:(UIViewAnimationOptions)transitionType  duration:(NSTimeInterval)duration
{
    if ( self.inTransition || self.topController == toViewController)
        return;
    
    self.inTransition = YES;
    UIViewController *fromViewController = self.topController;

    
    if (toViewController.hidesBottomBarWhenPushed)
    {
        toViewController.view.frame = self.contentArea.bounds;
        [self hideTabBar];
    }
    else
    {
        toViewController.view.frame = CGRectMake(0, 0, self.contentArea.bounds.size.width, self.contentArea.bounds.size.height - self.tabBar.frame.size.height);
        [self showTabBar];
    }
    
    [self addChildViewController:toViewController];
    
//    [self.contentArea addSubview:toViewController.view];
//    [toViewController beginAppearanceTransition:YES animated:YES];
    [toViewController viewWillAppear:YES];
    
    NSLog(@"Before transitionFromViewController:");
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:duration
                               options:transitionType// | UIViewAnimationOptionAllowAnimatedContent
                            animations:^{} 
                            completion:^(BOOL finished) {
                                [toViewController didMoveToParentViewController:self];
                                [self.selectedStack addObject:toViewController];
                                self.inTransition = NO;
                            }];
}

- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated)
    {
        [self pushController:viewController withTransitionType:UIViewAnimationOptionTransitionCrossDissolve duration:0.5];
    }
    else
    {
        [self pushController:viewController withTransitionType:UIViewAnimationOptionTransitionNone duration:0];
    }
}


#pragma mark - Pop

- (UIViewController*)popControllerWithTransitionType:(UIViewAnimationOptions)transitionType duration:(NSTimeInterval)duration
{
    NSInteger index = [self.selectedStack count] - 2;
    if ( self.inTransition || index < 0 ) {
        
        NSLog(@"Cannot pop. Already at root controller.");
        return nil;    
    }
    
    self.inTransition = YES;
    UIViewController *fromViewController = self.topController;
    UIViewController *toViewController = [self.selectedStack objectAtIndex:index];
    
    
    if (toViewController.hidesBottomBarWhenPushed)
    {
        toViewController.view.frame = self.contentArea.bounds;
        [self hideTabBar];
    }
    else
    {
        toViewController.view.frame = CGRectMake(0, 0, self.contentArea.bounds.size.width, self.contentArea.bounds.size.height - self.tabBar.frame.size.height);
        [self showTabBar];
    }
    
    [fromViewController willMoveToParentViewController:nil];
    [self transitionFromViewController:fromViewController 
                      toViewController:toViewController
                              duration:duration 
                               options:transitionType 
                            animations:^{} 
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                                [self.selectedStack removeLastObject];
                                self.inTransition = NO;
                            }];
    
    return fromViewController;
}

- (UIViewController*)popControllerWithTransitionType:(UIViewAnimationOptions)transitionType
{
    return [self popControllerWithTransitionType:transitionType duration:.5];
}

- (UIViewController*)popControllerAnimated:(BOOL)animated
{
    if (animated)
    {
        return [self popControllerWithTransitionType:UIViewAnimationOptionTransitionCrossDissolve duration:0.5];
    }
    else
    {
        return [self popControllerWithTransitionType:UIViewAnimationOptionTransitionNone duration:0];
    }
}


#pragma mark - Replace

- (void)replaceController:(UIViewController *)toViewController withTransitionType:(UIViewAnimationOptions)transitionType  duration:(NSTimeInterval)duration
{
    if ( self.inTransition || self.topController == toViewController)
        return;

    self.inTransition = YES;
    UIViewController *fromViewController = self.topController;

    if (toViewController.hidesBottomBarWhenPushed)
    {
        toViewController.view.frame = self.contentArea.bounds;
        [self hideTabBar];
    }
    else
    {
        toViewController.view.frame = CGRectMake(0, 0, self.contentArea.bounds.size.width, self.contentArea.bounds.size.height - self.tabBar.frame.size.height);
        [self showTabBar];
    }
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController 
                      toViewController:toViewController
                              duration:duration
                               options:transitionType 
                            animations:^{} 
                            completion:^(BOOL finished) {
                                
                                [fromViewController removeFromParentViewController];
                                [toViewController didMoveToParentViewController:self];
                                [self.selectedStack replaceObjectAtIndex:[self.selectedStack count] - 1 withObject:toViewController];
                                self.inTransition = NO;
                            }];
}

- (void)replaceController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated)
    {
        [self replaceController:viewController withTransitionType:UIViewAnimationOptionTransitionCrossDissolve duration:0.5];
    }
    else
    {
        [self replaceController:viewController withTransitionType:UIViewAnimationOptionTransitionNone duration:0];
    }
}

#pragma mark - Tab Bar Management

- (void)setupTabBar
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController *controller0 = [storyBoard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    UIViewController *controller1 = [storyBoard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    
    NSArray* rootViewControllers = @[controller0, controller1];

    NSMutableArray *forStacks = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in rootViewControllers)
    {
        [forStacks addObject:[NSMutableArray arrayWithObject:viewController]];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }

    self.stacks = [NSArray arrayWithArray:forStacks];
    self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:0];
    self.currentTabBarSelection = 0;

    
    UIViewController* firstViewController = controller0;
    
    if (firstViewController.hidesBottomBarWhenPushed)
    {
        firstViewController.view.frame = self.contentArea.bounds;
        [self hideTabBar];
    }
    else
    {
        firstViewController.view.frame = CGRectMake(0, 0, self.contentArea.bounds.size.width, self.contentArea.bounds.size.height - self.tabBar.frame.size.height);
        [self showTabBar];
    }
    
    [self.contentArea addSubview:firstViewController.view];
    [self.selectedStack addObject:firstViewController];


    /* Localization */
    [self.tabBar.items[TabBarIndexHome] setTitle:NSLocalizedString(@"HOME", @"Tab bar title")];
    [self.tabBar.items[TabBarIndexActivity] setTitle:NSLocalizedString(@"ACTIVITY", @"Tab bar title")];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.currentTabBarSelection == index)
        return;

    NSLog(@"ITEM SELECTED: %@ at index: %d", item, index);

    if ( !self.tabSwitching )
    {
        
        self.tabSwitching = YES;

        UIViewController* fromViewController = self.topController;
        UIViewController* toViewController = [[self.stacks objectAtIndex:index] lastObject];

        if (toViewController.hidesBottomBarWhenPushed)
        {
            toViewController.view.frame = self.contentArea.bounds;
            [self hideTabBar];
        }
        else
        {
            toViewController.view.frame = CGRectMake(0, 0, self.contentArea.bounds.size.width, self.contentArea.bounds.size.height - self.tabBar.frame.size.height);
            [self showTabBar];
        }
        
        [self transitionFromViewController:fromViewController
                          toViewController:toViewController
                                  duration:0 
                                   options:UIViewAnimationOptionTransitionNone 
                                animations:^{} 
                                completion:^(BOOL finished) {
                                    
                                    self.currentTabBarSelection = index;
                                    self.tabSwitching = NO;
                                    
                                    // Make sure we're showing the correct view.
                                    // It would be nice if there's a "tabBar: willSelectItem:" method.
                                    [self tabBar:tabBar didSelectItem:tabBar.selectedItem];
                                }
         ];
    }
}

- (void)showTabBar
{
    if (self.showingTabBar)
        return;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.tabBar setY:self.view.bounds.size.height - self.tabBar.bounds.size.height];
    } completion:^(BOOL finished) {
        self.showingTabBar = YES;
    }];
}

- (void)hideTabBar
{
    if (!self.showingTabBar)
        return;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tabBar setY:self.view.bounds.size.height];
    } completion:^(BOOL finished) {
        self.showingTabBar = NO;
    }];
}



@end
