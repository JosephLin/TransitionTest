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
    [self.descriptionLabel setY:50];
    self.descriptionLabel.text = @"viewDidLoad";
    self.descriptionLabel.backgroundColor = [UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.descriptionLabel setY:200];
    self.descriptionLabel.text = @"viewWillAppear";
    self.descriptionLabel.backgroundColor = [UIColor yellowColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.descriptionLabel setY:350];
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
    [[ContainerController containerController] popControllerAnimated:YES];
}


@end
