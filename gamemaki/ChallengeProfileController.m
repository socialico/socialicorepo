//
//  ChallengeProfileController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChallengeProfileController.h"

@implementation ChallengeProfileController

@synthesize challengeProfile = _challengeProfile;

- (id) initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    self = [super init];
    if (self != nil) {
        _challengeProfile = [query objectForKey:@"challengeObject"];
		NSLog(@"Name Destination: %@", _challengeProfile.userName);	
	}
    return self;
}

- (void)layout {
	TTFlowLayout* flowLayout = [[[TTFlowLayout alloc] init] autorelease];
	flowLayout.padding = 20;
	flowLayout.spacing = 20;
	CGSize size = [flowLayout layoutSubviews:self.view.subviews forView:self.view];
	
	UIScrollView* scrollView = (UIScrollView*)self.view;
	scrollView.contentSize = CGSizeMake(scrollView.width, size.height);
}


- (void)loadView {
	if (_challengeProfile.challengeTitle) {
		[super loadView];
		[super viewWillAppear:NO];
		[super viewDidAppear:NO];

		self.navigationBarTintColor = RGBCOLOR(41,41,41);
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.tableView.backgroundColor = RGBCOLOR(227,218,202);
//		self.tableView.separatorColor = RGBCOLOR(184,171,149);
		self.tableView.separatorColor = RGBCOLOR(227,218,202);
//		self.tableViewStyle = UITableViewStyleGrouped;
				
		TTStyledTextLabel* name = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		name.top = 0;
		name.left = 70;
		name.width =	self.view.width-70;
		name.font = [UIFont  boldSystemFontOfSize:16];
		name.text = [TTStyledText textFromXHTML:_challengeProfile.userName lineBreaks:YES URLs:YES];
		name.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		name.backgroundColor = RGBCOLOR(227,218,202);
		[name sizeToFit];
	
		TTImageView* category = [[[TTImageView alloc] initWithFrame:CGRectMake(70, 120, 25.f, 25.f)]autorelease];
		category.autoresizesToImage = NO;
		category.contentScaleFactor = 2.0;
		category.contentMode = UIViewContentModeScaleAspectFit;
		category.top = name.bottom;
//		category.backgroundColor = [UIColor clearColor]; 
		category.backgroundColor = RGBCOLOR(227,218,202);
		category.urlPath = _challengeProfile.categoryIcon;
	
		//Category name has &. Replace it!
		NSString* cleanCategoryName = _challengeProfile.categoryName;
		cleanCategoryName = [cleanCategoryName stringByReplacingOccurrencesOfString:@" & " withString:@" &amp; "];
	
		TTStyledTextLabel* categoryName = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		categoryName.top = name.bottom;;
		categoryName.left = category.right;
		categoryName.width = categoryName.left + 20;
		categoryName.font = [UIFont systemFontOfSize:12];
		categoryName.text = [TTStyledText textFromXHTML:cleanCategoryName lineBreaks:NO URLs:YES];
		categoryName.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		categoryName.backgroundColor = RGBCOLOR(227,218,202);
		[categoryName sizeToFit];
		
		//Convert createdAt into string with interval 
		NSString *createdAgo = [[NSString alloc] autorelease];
		NSDate *dateStart = _challengeProfile.createdAt;
		NSDate *now = [NSDate date];
		double time = [dateStart timeIntervalSinceDate:now];
		time *= -1;
		if(time < 1) {
			createdAgo = @"Now";
		} else if (time < 60) {
			createdAgo =  @"less than a minute ago";
		} else if (time < 3600) {
			int diff = round(time / 60);
			if (diff == 1) 
				createdAgo = [NSString stringWithFormat:@"1 minute ago", diff];
			createdAgo = [NSString stringWithFormat:@"%d minutes ago", diff];
		} else if (time < 86400) {
			int diff = round(time / 60 / 60);
			if (diff == 1)
				createdAgo = [NSString stringWithFormat:@"1 hour ago", diff];
			createdAgo = [NSString stringWithFormat:@"%d hours ago", diff];
		} else if (time < 604800) {
			int diff = round(time / 60 / 60 / 24);
			if (diff == 1) 
				createdAgo = [NSString stringWithFormat:@"yesterday", diff];
			if (diff == 7) 
				createdAgo = [NSString stringWithFormat:@"last week", diff];
			createdAgo = [NSString stringWithFormat:@"%d days ago", diff];
		} else {
			int diff = round(time / 60 / 60 / 24 / 7);
			if (diff == 1)
				createdAgo = [NSString stringWithFormat:@"last week", diff];
			createdAgo = [NSString stringWithFormat:@"%d weeks ago", diff];
		} 
		
				
		TTStyledTextLabel* createdTime = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		createdTime.top = name.bottom;;
		createdTime.left = categoryName.right;
		createdTime.width = self.view.width-70;
		createdTime.font = [UIFont boldSystemFontOfSize:12];
		createdTime.text = [TTStyledText textFromXHTML:createdAgo lineBreaks:NO URLs:YES];
		createdTime.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		createdTime.backgroundColor = RGBCOLOR(227,218,202);
		[createdTime sizeToFit];

		TTImageView* avatar = [[[TTImageView alloc] initWithFrame:CGRectMake(5, 5, 50.f, 50.f)]autorelease];
		avatar.autoresizesToImage = NO;
		avatar.contentScaleFactor = 2.0;
		avatar.contentMode = UIViewContentModeScaleAspectFit;
		avatar.urlPath = _challengeProfile.photoSmall;
		avatar.backgroundColor = RGBCOLOR(227,218,202); 
		avatar.defaultImage = nil; 
	
		TTStyledTextLabel* title = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		title.top = avatar.bottom;
		title.left = 20;
		title.width =	self.view.width-20;
		title.font = [UIFont systemFontOfSize:18];
		title.text = [TTStyledText textFromXHTML:_challengeProfile.challengeTitle lineBreaks:YES URLs:YES];
		title.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		title.backgroundColor = RGBCOLOR(227,218,202);
		[title sizeToFit];

		TTStyledTextLabel* claimed = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		NSString* claimedNo = [NSString stringWithFormat:@"<b>%@</b> claimed", _challengeProfile.claimNo];
		claimed.text = [TTStyledText textFromXHTML:claimedNo lineBreaks:NO URLs:NO];
		claimed.font = [UIFont systemFontOfSize:16];
		claimed.top = title.bottom;
		claimed.contentInset = UIEdgeInsetsMake(10, self.view.width/2 - 40, 10, 0);
		claimed.backgroundColor = RGBCOLOR(184,171,149);
		[claimed sizeToFit];

		TTImageView* claimedImage = [[[TTImageView alloc] initWithFrame:CGRectMake(0, 0, 25.f, 25.f)]autorelease];
		claimedImage.autoresizesToImage = NO;
		claimedImage.contentScaleFactor = 2.0;
		claimedImage.bottom = title.bottom + 30;
		claimedImage.left = self.view.width/2 - 70;
		claimedImage.contentMode = UIViewContentModeScaleAspectFit;
		claimedImage.urlPath = @"bundle://stats_claimed.png";
		claimedImage.backgroundColor = RGBCOLOR(184,171,149);

		TTTableHeaderView *tableHeaderView = [[TTTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, claimed.bottom)]; 
		[tableHeaderView addSubview:_searchController.searchBar];
		[tableHeaderView setUserInteractionEnabled:YES];
		[tableHeaderView addSubview:name];
		[tableHeaderView addSubview:category];
		[tableHeaderView addSubview:categoryName];
		[tableHeaderView addSubview:createdTime];
		[tableHeaderView addSubview:avatar];
		[tableHeaderView addSubview:title];
		[tableHeaderView addSubview:claimed];
		[tableHeaderView addSubview:claimedImage];
		tableHeaderView.backgroundColor = RGBCOLOR(227,218,202);


//		UIButton* buttonCreated = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[buttonCreated setTitle:@" 4 Created " forState:UIControlStateNormal];
//		[buttonCreated addTarget:@"tt://order/food" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
//		[buttonCreated sizeToFit];
//		buttonCreated.width = floor(self.view.width/2 - 20);
//		buttonCreated.top = claimed.bottom + 5;
//		buttonCreated.left = floor(self.view.width/2 - buttonCreated.width);
//		[self.view addSubview:buttonCreated];
//	
//		UIButton* buttonClaimed = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[buttonClaimed setTitle:@"16 Claimed" forState:UIControlStateNormal];
//		[buttonClaimed addTarget:@"tt://order/food" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
//		[buttonClaimed sizeToFit];
//		buttonClaimed.top = claimed.bottom + 5;
//		buttonClaimed.width = floor(self.view.width/2 - 20);
//		buttonClaimed.left = floor(self.view.width/2 + 10);
//		[self.view addSubview:buttonClaimed];

		[self.tableView setTableHeaderView:tableHeaderView]; 
		[tableHeaderView release];
		
		//Category name has &. Replace it!
		NSString* commentsNo = [[NSString alloc] initWithFormat:@"Be the first to comment"];
		if ([_challengeProfile.commentNo intValue] == 1) commentsNo = [NSString stringWithFormat:@"%@ comment", _challengeProfile.commentNo];
		if ([_challengeProfile.commentNo intValue] != 0 && [_challengeProfile.commentNo intValue] != 1) commentsNo = [NSString stringWithFormat:@"%@ comments", _challengeProfile.commentNo];
		NSString* claimesNo = [[NSString alloc] initWithFormat:@"Be the first to claim"];
		if ([_challengeProfile.claimNo intValue] == 1 ) claimesNo = [NSString stringWithFormat:@"%@ claim", _challengeProfile.claimNo];
		if ([_challengeProfile.claimNo intValue] != 0 && [_challengeProfile.claimNo intValue] != 1) claimesNo = [NSString stringWithFormat:@"%@ claimes", _challengeProfile.claimNo];

						 
		self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
							@"",
							[TTTableSubtitleItem itemWithText:commentsNo subtitle:@"Damon: Tough, real tough challenge especially if I have to do it at this moment." imageURL:nil  defaultImage:TTIMAGE(@"bundle://comments.png") URL:@"tt://food/macncheese" accessoryURL:nil],
							[TTTableSubtitleItem itemWithText:claimesNo subtitle:@"Last claimed by Brenda" imageURL:nil  defaultImage:TTIMAGE(@"bundle://claimed.png") URL:@"tt://food/macncheese" accessoryURL:nil],
							nil];
		

		
		
	}
	else{
		//challengeTitle is empty and we go back to the previous view
		[self.navigationController popViewControllerAnimated:YES];
	}
	
}

- (void)dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)orderAction:(NSString*)action {
	TTDINFO(@"ACTION: %@", action);
}


@end
