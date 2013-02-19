//
//  DetailViewController.m
//  TransitionTest
//
//  Created by Joseph Lin on 1/30/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "DetailViewController.h"
#import "ContainerController.h"
#import "UIBarButtonItem+AppAppearance.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@end


@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGRect rect = self.descriptionLabel.frame;
    rect.origin.y = 50;
    self.descriptionLabel.frame = rect;
    self.descriptionLabel.text = @"viewDidLoad";
    self.descriptionLabel.backgroundColor = [UIColor redColor];
    
    NSArray *items = [self.toolbar.items arrayByAddingObjectsFromArray:@[self.navigationBar.topItem.leftBarButtonItem, self.navigationBar.topItem.rightBarButtonItem]];

    for (UIBarButtonItem *item in items)
    {
        [item setAppBackground];
        [item setAppFont];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGRect rect = self.descriptionLabel.frame;
    rect.origin.y = 200;
    self.descriptionLabel.frame = rect;
    self.descriptionLabel.text = @"viewWillAppear";
    self.descriptionLabel.backgroundColor = [UIColor yellowColor];
    
    [self.view layoutIfNeeded];
    [self.toolbar layoutIfNeeded];
    [self.navigationBar layoutIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGRect rect = self.descriptionLabel.frame;
    rect.origin.y = 350;
    self.descriptionLabel.frame = rect;
    self.descriptionLabel.text = @"viewDidAppear";
    self.descriptionLabel.backgroundColor = [UIColor greenColor];
}

- (void)viewWillLayoutSubviews
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)backButtonTapped:(id)sender
{
    [[ContainerController containerController] popController];
}


@end
