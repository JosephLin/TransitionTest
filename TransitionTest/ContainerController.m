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


@interface ContainerController ()
@property (nonatomic, strong) IBOutlet UIView *contentArea;
@end



@implementation ContainerController


#pragma mark - shortcut

+ (ContainerController*)containerController
{
    return (ContainerController*)((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
}

- (UIViewController *)topViewController
{
    return [self.childViewControllers lastObject];
}

//- (BOOL) shouldAutomaticallyForwardAppearanceMethods
//{
//    return NO;
//}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = YES;
    self.contentArea.autoresizesSubviews = YES;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    
    [self addChildViewController:controller];
    controller.view.frame = self.contentArea.bounds;
    [self.contentArea addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}


#pragma mark - Push

- (void)pushController:(UIViewController *)toViewController withTransitionType:(UIViewAnimationOptions)transitionType  duration:(NSTimeInterval)duration
{
    NSLog(@"%@", self.childViewControllers);

    UIViewController *fromViewController = self.topViewController;
    
    [self addChildViewController:toViewController];

    toViewController.view.frame = self.contentArea.bounds;
    
    NSLog(@"%@", self.childViewControllers);

//    [self.contentArea addSubview:toViewController.view];
//    [toViewController beginAppearanceTransition:YES animated:YES];
//    [toViewController viewWillAppear:YES];
    
    NSLog(@"Before transitionFromViewController:");
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:duration
                               options:transitionType// | UIViewAnimationOptionAllowAnimatedContent
                            animations:^{} 
                            completion:^(BOOL finished) {
                                [toViewController didMoveToParentViewController:self];
//                                [toViewController endAppearanceTransition];
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
    NSInteger index = [self.childViewControllers count] - 2;
    UIViewController *fromViewController = self.topViewController;
    UIViewController *toViewController = self.childViewControllers[index];
    
    
    [fromViewController willMoveToParentViewController:nil];

    toViewController.view.frame = self.contentArea.bounds;
    
    [self transitionFromViewController:fromViewController 
                      toViewController:toViewController
                              duration:duration 
                               options:transitionType 
                            animations:^{} 
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                            }];
    
    return fromViewController;
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





@end
