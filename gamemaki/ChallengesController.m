//
//  ChallengesController.m
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import "ChallengesController.h"
#import "ChallengesDataSource.h"
#import "Challenge.h"
#import "ChallengeFeedModel.h"
#import "GlobalStore.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ChallengesController

@synthesize categoryId = _categoryId;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCategoryId:(NSString*)category {
	if (self == [super init]) {
		
		//Styling Properties
		self.navigationBarTintColor = RGBCOLOR(41,41,41);
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		//Assigning category ID
		self.categoryId = category;
		
		//Printing table title name
		if([category isEqualToString:@"0"])
			self.title = @"Latest";
		else if([category isEqualToString:@"1"])
			self.title = @"Arts & Entertainment";
		else if([category isEqualToString:@"13"])
			self.title = @"Friendship";
		else if([category isEqualToString:@"2"])
			self.title = @"Knowledge";
		else if([category isEqualToString:@"5"])
			self.title = @"Health & Wellness";
		else if([category isEqualToString:@"9"])
			self.title = @"Shopping";
		else if([category isEqualToString:@"10"])
			self.title = @"Travel";
		else if([category isEqualToString:@"4"])
			self.title = @"Wine & Dine";
		else if([category isEqualToString:@"12"])
			self.title = @"Just for Fun";
		
		self.variableHeightRows = YES;
	}
	return self;
}

- (void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
	//Retrieve challenge object
	ChallengesDataSource* dataList = self.dataSource;
	ChallengeFeedModel* dataModel = dataList.model;

	//If not load more button class
	if([object class] != [TTTableMoreButton class]) {
		NSArray* challengesList= dataModel.challengelist;
		Challenge* challenge = [challengesList objectAtIndex:indexPath.row];
	
		//Open challenge profile view controller
		TTURLAction *action =  [[[TTURLAction actionWithURLPath:@"tt://challengeProfile"] 
							applyQuery:[NSDictionary dictionaryWithObject:challenge forKey:@"challengeObject"]]
							applyAnimated:YES];
	
		[[TTNavigator navigator] openURLAction:action];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
    if (self.categoryId == nil) {
        NSString* sessionKey = [GlobalStore sharedInstance].sessionKey;
        self.dataSource = [[[ChallengesDataSource alloc] initWithSessionKey:sessionKey] autorelease];
    } else {
        self.dataSource = [[[ChallengesDataSource alloc] initWithSearchQuery:self.categoryId] autorelease];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}


@end
