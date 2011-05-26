//
//  TabBarController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarController.h"


@implementation TabBarController

- (void)viewDidLoad {
    [self setTabURLs:[NSArray arrayWithObjects:
            @"tt://menu/1",
            @"tt://menu/2",
            @"tt://menu/3",
    nil]];
}

@end
