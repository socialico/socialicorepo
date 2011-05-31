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
	[super loadView];
	self.navigationBarTintColor = RGBCOLOR(41,41,41);
	self.statusBarStyle = UIStatusBarStyleBlackOpaque;

	TTStyledTextLabel* name = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
//	name.top = 0;
//	name.left = 70;
//	name.width =	self.view.width-70;
	name.font = [UIFont systemFontOfSize:22];
	
	name.text = [TTStyledText textFromXHTML:_challengeProfile.challengeTitle lineBreaks:YES URLs:YES];
	name.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
	//label1.backgroundColor = [UIColor grayColor];
	[name sizeToFit];
	[self.view addSubview:name];
	
	TTImageView* avatar = [[[TTImageView alloc] initWithFrame:CGRectMake(5, 5, 0, 0)]autorelease];
	avatar.autoresizesToImage = YES;
	avatar.contentScaleFactor = 2;
	avatar.urlPath = _challengeProfile.photoSmall;
	[self.view addSubview:avatar];	
}

- (void)dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)orderAction:(NSString*)action {
	TTDINFO(@"ACTION: %@", action);
}


@end
