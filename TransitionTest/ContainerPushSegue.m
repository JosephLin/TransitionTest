//
//  ContainerPushSegue.m
//  NikeBasketball
//
//  Created by Noah Keating on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContainerPushSegue.h"
#import "ContainerController.h"


@implementation ContainerPushSegue

- (void)perform
{
    [[ContainerController containerController] pushController:self.destinationViewController animated:YES];
}

@end
