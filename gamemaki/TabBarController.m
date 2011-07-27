//
//  TabBarController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"


@implementation TabBarController

- (void)loadView {
	[super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];
    
    [self setTabURLs:[NSArray arrayWithObjects:
                      @"tt://users/me/challenges",
                      @"tt://categories",
                      @"tt://camera",
                      @"tt://map",
                      @"tt://location/me/challenges",
                      nil]];
    
    //self.selectedIndex = 1;
    
    self.navigationController.navigationBar.hidden = YES;
}

@end