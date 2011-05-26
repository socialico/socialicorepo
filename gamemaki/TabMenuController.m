//
//  TabMenuController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabMenuController.h"


@implementation TabMenuController
@synthesize page = _page;

- (NSString*)nameForMenuPage:(MenuPage)page {
    switch (page) {
        case MenuHome:
            return @"Home";
        case MenuChallenges:
            return @"Challenges";
        case MenuMe:
            return @"Me";
        default:
            return @"";
    }
}

- (id)initWithMenu:(MenuPage)page {
    if (self == [super init]) {
        self.page = page;
    }
    return self;
}

- (id)init {
    if (self == [super init]) {
        _page = MenuNone;
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_tabBar1);
    TT_RELEASE_SAFELY(_tabBar2);
    TT_RELEASE_SAFELY(_tabBar3);
    [super dealloc];
}

- (void)setPage:(MenuPage)page {
    _page = page;
    
    self.title = [self nameForMenuPage:page];
	self.variableHeightRows = YES;
    
	if (_page == MenuHome) {
		UIImage* image = [UIImage imageNamed:@"home.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
	} else if (_page == MenuChallenges) {
		UIImage* image = [UIImage imageNamed:@"challenges.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:1] autorelease];	
	} else if (_page == MenuMe) {
		UIImage* image = [UIImage imageNamed:@"me.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:2] autorelease];
    }
}

@end
