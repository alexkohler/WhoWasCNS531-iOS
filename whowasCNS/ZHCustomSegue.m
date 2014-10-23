//
//  ZHCustomSegue.m
//  whowasCNS
//
//  Created by Alexander Kohler on 10/23/14.
//  Copyright (c) 2014 Kohlerbear. All rights reserved.
//

#import "ZHCustomSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation ZHCustomSegue


-(void)perform {
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = .25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    
    
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    
    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    
}
@end

