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

- (void)loadView {
	if (_challengeProfile.challengeTitle) {
		[super loadView];
		self.navigationBarTintColor = RGBCOLOR(41,41,41);
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.view.backgroundColor = RGBCOLOR(227,218,202);
		
		TTStyledTextLabel* name = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		name.top = 0;
		name.left = 70;
		name.width =	self.view.width-70;
		name.font = [UIFont  boldSystemFontOfSize:15];
		name.text = [TTStyledText textFromXHTML:_challengeProfile.userName lineBreaks:YES URLs:YES];
		name.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		name.backgroundColor = RGBCOLOR(227,218,202);
		[name sizeToFit];
		[self.view addSubview:name];
	
		TTImageView* category = [[[TTImageView alloc] initWithFrame:CGRectMake(70, 120, 25.f, 25.f)]autorelease];
		category.autoresizesToImage = NO;
		category.contentScaleFactor = 2.0;
		category.contentMode = UIViewContentModeScaleAspectFit;
		category.top = name.bottom;
//		category.backgroundColor = [UIColor clearColor]; 
		category.backgroundColor = RGBCOLOR(227,218,202);
		category.urlPath = _challengeProfile.categoryIcon;
		[self.view addSubview:category];
	
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
		[self.view addSubview:categoryName];
		
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
		createdTime.font = [UIFont systemFontOfSize:12];
		createdTime.text = [TTStyledText textFromXHTML:createdAgo lineBreaks:NO URLs:YES];
		createdTime.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		createdTime.backgroundColor = RGBCOLOR(227,218,202);
		[createdTime sizeToFit];
		[self.view addSubview:createdTime];
		

		TTImageView* avatar = [[[TTImageView alloc] initWithFrame:CGRectMake(5, 5, 50.f, 50.f)]autorelease];
		avatar.autoresizesToImage = NO;
		avatar.contentScaleFactor = 2.0;
		avatar.contentMode = UIViewContentModeScaleAspectFit;
		avatar.urlPath = _challengeProfile.photoSmall;
		avatar.backgroundColor = RGBCOLOR(227,218,202); 
		avatar.defaultImage = nil; 
		[self.view addSubview:avatar];	
	
		TTStyledTextLabel* title = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		title.top = avatar.bottom;
		title.left = 20;
		title.width =	self.view.width-20;
		title.font = [UIFont systemFontOfSize:18];
		title.text = [TTStyledText textFromXHTML:_challengeProfile.challengeTitle lineBreaks:YES URLs:YES];
		title.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
		title.backgroundColor = RGBCOLOR(227,218,202);
		[title sizeToFit];
		[self.view addSubview:title];
	
		TTStyledTextLabel* claimed = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
		NSString* claimedNo = [NSString stringWithFormat:@"<b>%@</b> claimed", _challengeProfile.claimNo];
		claimed.text = [TTStyledText textFromXHTML:claimedNo lineBreaks:NO URLs:NO];
		claimed.font = [UIFont systemFontOfSize:16];
		claimed.top = title.bottom + 1;
		claimed.contentInset = UIEdgeInsetsMake(10, self.view.width/2 - 40, 10, 0);
		//		claimed.left = floor(self.view.width/2 - 60);
		claimed.backgroundColor = RGBCOLOR(184,171,149);
		[claimed sizeToFit];
		[self.view addSubview:claimed];
		
		TTImageView* claimedImage = [[[TTImageView alloc] initWithFrame:CGRectMake(0, 0, 25.f, 25.f)]autorelease];
		claimedImage.autoresizesToImage = NO;
		claimedImage.contentScaleFactor = 2.0;
		claimedImage.top = title.bottom + 5;
		claimedImage.left = self.view.width/2 - 70;
		claimedImage.contentMode = UIViewContentModeScaleAspectFit;
		claimedImage.urlPath = @"bundle://stats_claimed.png";
		claimedImage.backgroundColor = RGBCOLOR(184,171,149);
		[self.view addSubview:claimedImage];	

		UIButton* buttonCreated = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[buttonCreated setTitle:@" 4 Created " forState:UIControlStateNormal];
		[buttonCreated addTarget:@"tt://order/food" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
		[buttonCreated sizeToFit];
		buttonCreated.width = floor(self.view.width/2 - 20);
		buttonCreated.top = claimed.bottom + 5;
		buttonCreated.left = floor(self.view.width/2 - buttonCreated.width);
		[self.view addSubview:buttonCreated];
	
		UIButton* buttonClaimed = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[buttonClaimed setTitle:@"16 Claimed" forState:UIControlStateNormal];
		[buttonClaimed addTarget:@"tt://order/food" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
		[buttonClaimed sizeToFit];
		buttonClaimed.top = claimed.bottom + 5;
		buttonClaimed.width = floor(self.view.width/2 - 20);
		buttonClaimed.left = floor(self.view.width/2 + 10);
		[self.view addSubview:buttonClaimed];
	

		
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
