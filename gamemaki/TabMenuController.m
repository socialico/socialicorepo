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
			[TTTableSubtitleItem itemWithText:@"Latest" subtitle:@"" imageURL:nil defaultImage:TTIMAGE(@"bundle://cat_icon_latest.png") URL:@"tt://challengesList/0" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Arts & Culture" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_arts_culture.png") URL:@"tt://challengesList/1" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Knowledge" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_knowledge.png") URL:@"tt://challengesList/2" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Entertainment" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_entertainment.png") URL:@"tt://challengesList/3" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Wine & Dine" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_wine_dine.png") URL:@"tt://challengesList/4" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Health & Fitness" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_health_wellness.png") URL:@"tt://challengesList/5" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Photography" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_photography.png") URL:@"tt://challengesList/6" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Productivity" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_productivity.png") URL:@"tt://challengesList/7" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Shopping" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_shopping.png") URL:@"tt://challengesList/9" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Technology" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_technology.png") URL:@"tt://challengesList/8" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Travel" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_travel.png") URL:@"tt://challengesList/10" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Others" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_others.png") URL:@"tt://challengesList/11" accessoryURL:nil],
			[TTTableSubtitleItem itemWithText:@"Just for Fun" subtitle:@"" imageURL:nil  defaultImage:TTIMAGE(@"bundle://cat_icon_just_for_fun.png") URL:@"tt://challengesList/12" accessoryURL:nil],
		nil];
	} 
}

@end
