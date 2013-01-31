//
//  ContainerPushSegue.m
//  TransitionTest
//
//  Created by Joseph Lin on 1/17/12.
//  Copyright (c) 2012 Joseph Lin. All rights reserved.
//

#import "ContainerPushSegue.h"
#import "ContainerController.h"


@implementation ContainerPushSegue

- (void)perform
{
    [[ContainerController containerController] pushController:self.destinationViewController animated:YES];
}

@end
