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
@property (nonatomic, strong) NSMutableArray* stack;
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
    return [self.stack lastObject];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = YES;
    self.contentArea.autoresizesSubviews = YES;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    
    self.stack = [NSMutableArray array];
    [self.stack addObject:controller];
    
    [self addChildViewController:controller];
    controller.view.frame = self.contentArea.bounds;
    [self.contentArea addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}


#pragma mark - Push

- (void)pushController:(UIViewController *)toViewController withTransitionType:(UIViewAnimationOptions)transitionType  duration:(NSTimeInterval)duration
{
    if ( self.inTransition || self.topController == toViewController)
        return;
    
    self.inTransition = YES;
    UIViewController *fromViewController = self.topController;

    toViewController.view.frame = self.contentArea.bounds;
    
    [self addChildViewController:toViewController];
    
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
                                [self.stack addObject:toViewController];
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
    NSInteger index = [self.stack count] - 2;
    if ( self.inTransition || index < 0 ) {
        
        NSLog(@"Cannot pop. Already at root controller.");
        return nil;    
    }
    
    self.inTransition = YES;
    UIViewController *fromViewController = self.topController;
    UIViewController *toViewController = [self.stack objectAtIndex:index];
    
    
    toViewController.view.frame = self.contentArea.bounds;
    
    [fromViewController willMoveToParentViewController:nil];
    [self transitionFromViewController:fromViewController 
                      toViewController:toViewController
                              duration:duration 
                               options:transitionType 
                            animations:^{} 
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                                [self.stack removeLastObject];
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





@end
