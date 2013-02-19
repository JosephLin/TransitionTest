//
//  ContainerController.m
//  TransitionTest
//
//  Created by Joseph Lin on 10/31/11.
//  Copyright (c) 2011 Joseph Lin. All rights reserved.
//

#import "ContainerController.h"
#import "MasterViewController.h"


@interface ContainerController ()
@end



@implementation ContainerController


#pragma mark - shortcut

+ (ContainerController*)containerController
{
    return (ContainerController*)((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = YES;
    self.view.autoresizesSubviews = YES;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    
    [self addChildViewController:controller];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}


#pragma mark - Push

- (void)pushController:(UIViewController *)toViewController
{
    UIViewController *fromViewController = [self.childViewControllers lastObject];
    
    [self addChildViewController:toViewController];
    toViewController.view.frame = self.view.bounds;

//    [toViewController.view layoutIfNeeded];
    [toViewController beginAppearanceTransition:YES animated:YES];
    
    NSLog(@"Before transitionFromViewController:");
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve //| UIViewAnimationOptionAllowAnimatedContent
                            animations:^{}
                            completion:^(BOOL finished) {
                                [toViewController didMoveToParentViewController:self];
                                [toViewController endAppearanceTransition];
                            }];    
}


#pragma mark - Pop

- (UIViewController*)popController
{
    NSInteger index = [self.childViewControllers count] - 2;
    UIViewController *fromViewController = [self.childViewControllers lastObject];
    UIViewController *toViewController = self.childViewControllers[index];
    
    
    [fromViewController willMoveToParentViewController:nil];

    toViewController.view.frame = self.view.bounds;
    
    [self transitionFromViewController:fromViewController 
                      toViewController:toViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve 
                            animations:^{} 
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                            }];
    
    return fromViewController;
}






@end
