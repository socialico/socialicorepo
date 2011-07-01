//
//  TabMenuController.h
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "FBConnect.h"

typedef enum {
    MenuNone,
    MenuHome,
    MenuChallenges,
    MenuMe
} MenuPage;

@interface TabMenuController : TTTableViewController {
    MenuPage _page;
	TTTabBar* _tabBar1;
    TTTabBar* _tabBar2;
    TTTabBar* _tabBar3;
}

@property(nonatomic) MenuPage page;

@end
