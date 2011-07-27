//
//  TabMenuController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoriesController.h"

@implementation CategoriesController

- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    
    if (self == [super initWithNavigatorURL:URL query:query]) {
        //setup navigation bar
        UIImage *barLogo = [UIImage imageNamed:@"nav_bar_logo"];
        UIImageView *barLogoView = [[UIImageView alloc] initWithImage:barLogo];
        self.navigationItem.titleView = barLogoView;
        self.navigationBarTintColor = RGBCOLOR(41,41,41);
        self.statusBarStyle = UIStatusBarStyleBlackOpaque;
        self.title = @"Challenges";
        
        //setup tab bar item
        UIImage* image = [UIImage imageNamed:@"challenges.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:1] autorelease];
        
        //setup categories in table
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
        
        self.variableHeightRows = YES;
    }
    
    return self;
}

@end
