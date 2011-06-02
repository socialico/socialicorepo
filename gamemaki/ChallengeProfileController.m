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
	name.top = 0;
	name.left = 70;
	name.width =	self.view.width-70;
	name.font = [UIFont systemFontOfSize:14];
	name.text = [TTStyledText textFromXHTML:_challengeProfile.userName lineBreaks:YES URLs:YES];
	name.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
	//label1.backgroundColor = [UIColor grayColor];
	[name sizeToFit];
	[self.view addSubview:name];
	
	TTImageView* category = [[[TTImageView alloc] initWithFrame:CGRectMake(5, 5, 0, 0)]autorelease];
	category.top = name.bottom;
	category.autoresizesToImage = YES;
	category.contentScaleFactor = 2;
	category.urlPath = _challengeProfile.categoryIcon;
	[self.view addSubview:category];
	
	TTImageView* avatar = [[[TTImageView alloc] initWithFrame:CGRectMake(5, 5, 0, 0)]autorelease];
	avatar.autoresizesToImage = YES;
	avatar.contentScaleFactor = 2;
	avatar.urlPath = _challengeProfile.photoSmall;
	[self.view addSubview:avatar];	
	
	TTStyledTextLabel* bio = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
	bio.top = avatar.bottom;
	bio.left = 20;
	bio.width =	self.view.width-20;
	bio.font = [UIFont systemFontOfSize:18];
	bio.text = [TTStyledText textFromXHTML:_challengeProfile.challengeTitle lineBreaks:YES URLs:YES];
	bio.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
	//label1.backgroundColor = [UIColor grayColor];
	[bio sizeToFit];
	[self.view addSubview:bio];
	
    UIButton* buttonCreated = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonCreated setTitle:@" 4 Created " forState:UIControlStateNormal];
    [buttonCreated addTarget:@"tt://order/food" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonCreated sizeToFit];
    buttonCreated.width = floor(self.view.width/2 - 20);
    buttonCreated.top = bio.bottom + 5;
    buttonCreated.left = floor(self.view.width/2 - buttonCreated.width);
    [self.view addSubview:buttonCreated];
	
    UIButton* buttonClaimed = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonClaimed setTitle:@"16 Claimed" forState:UIControlStateNormal];
    [buttonClaimed addTarget:@"tt://order/food" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonClaimed sizeToFit];
    buttonClaimed.top = bio.bottom + 5;
	buttonClaimed.width = floor(self.view.width/2 - 20);
    buttonClaimed.left = floor(self.view.width/2 + 10);
    [self.view addSubview:buttonClaimed];
	
	TTStyledTextLabel* points = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
	points.text = [TTStyledText textFromXHTML:@"Total points: <b>470</b>" lineBreaks:NO URLs:NO];
	points.font = [UIFont systemFontOfSize:16];
	points.top = buttonClaimed.bottom + 5;
	points.left = floor(self.view.width/2 - 60);
	[points sizeToFit];
	[self.view addSubview:points];
	
	

}

- (void)dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)orderAction:(NSString*)action {
	TTDINFO(@"ACTION: %@", action);
}


@end
