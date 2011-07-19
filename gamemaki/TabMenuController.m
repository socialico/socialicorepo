//
//  TabMenuController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabMenuController.h"
#import "ChallengesDataSource.h"
#import "GlobalStore.h"

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
	
	//Styling Properties
	UIImage *barLogo = [UIImage imageNamed:@"nav_bar_logo"];
	UIImageView *barLogoView = [[UIImageView alloc] initWithImage:barLogo];
	self.navigationItem.titleView = barLogoView;
	self.navigationBarTintColor = RGBCOLOR(41,41,41);
	self.statusBarStyle = UIStatusBarStyleBlackOpaque;
    
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
    
    if (_page == MenuChallenges) {
        self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
			@"",
			[TTTableSubtitleItem itemWithText:@"Latest" subtitle:@"" imageURL:nil defaultImage:TTIMAGE(@"bundle://cat_icon_latest.png") URL:@"tt://categories/0/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Arts & Entertainment" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_arts_culture.png") URL:@"tt://categories/1/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Friendship" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_knowledge.png") URL:@"tt://categories/13/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Knowledge" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_knowledge.png") URL:@"tt://categories/2/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Health & Wellness" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_health_wellness.png") URL:@"tt://categories/5/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Shopping" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_shopping.png") URL:@"tt://categories/9/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Travel" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_travel.png") URL:@"tt://categories/10/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Wine & Dine" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_wine_dine.png") URL:@"tt://categories/4/challenges" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Just for Fun" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_just_for_fun.png") URL:@"tt://categories/12/challenges" accessoryURL:nil],
		nil];
	} 
}

@end
