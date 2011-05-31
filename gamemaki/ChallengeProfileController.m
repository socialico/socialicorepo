//
//  ChallengeProfileController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChallengeProfileController.h"
#import "Challenge.h"

@implementation ChallengeProfileController

@synthesize challengeId = _challengeId;

- (id)initWithChallengeId:(NSString*)challengeId {
	
	//Styling Properties
	self.navigationBarTintColor = RGBCOLOR(41,41,41);
	self.statusBarStyle = UIStatusBarStyleBlackOpaque;
	    
	NSString* webchallengeUrl = [NSString stringWithFormat:@"http://m.gamemaki.com/main/challenge_m?id=%@", challengeId];
	TTOpenURL(webchallengeUrl);

	return self;
}

- (id) initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    self = [super init];
    if (self != nil) {
        Challenge* challenge = [query objectForKey:@"challengeObject"];
		NSLog(@"Name Destination: %@", challenge.userName);
    }
    return self;
}


@end
