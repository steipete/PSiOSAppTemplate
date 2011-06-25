//
//  PSBaseViewController.m
//  PSAppTemplate
//
//  Created by Tretter Matthias on 25.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "PSBaseViewController.h"

@implementation PSBaseViewController

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
    }
    
    return self;
}

- (void)dealloc {
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PSReachability sharedPSReachability] setupReachabilityFor:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [[PSReachability sharedPSReachability] shutdownReachabilityFor:self];
}

@end
