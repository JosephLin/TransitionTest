//
//  DetailViewController.m
//  TransitionTest
//
//  Created by Joseph Lin on 1/30/13.
//  Copyright (c) 2013 Joseph Lin. All rights reserved.
//

#import "DetailViewController.h"
#import "ContainerController.h"
#import "UIView+Additions.h"

@interface DetailViewController ()
@end


@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.descriptionLabel setY:200];
    self.descriptionLabel.text = @"viewWillAppear";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.descriptionLabel setY:300];
    self.descriptionLabel.text = @"viewDidAppear";
}


- (IBAction)backButtonTapped:(id)sender
{
    [[ContainerController containerController] popControllerAnimated:YES];
}


@end
