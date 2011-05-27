//
//  ChallengeProfileController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChallengeProfileController.h"


@implementation ChallengeProfileController

@synthesize challengeId = _challengeId;

- (id)initWithChallengeId:(NSString*)challengeId {
	
	NSString* webchallengeUrl = [NSString stringWithFormat:@"http://m.gamemaki.com/main/challenge_m?id=%@", challengeId];
	TTOpenURL(webchallengeUrl);

	return self;
}

@end
