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

- (id)initWithChallengeId:(NSString*)challenge {
	// Initialize controller for the web browser
	TTWebController *webController = [[[TTWebController alloc] init] autorelease];
	[webController openURL:[NSURL URLWithString:@"http://www.three20.info/"]];
	
	// Push the controller to the navigation controller stack
	[self.navigationController pushViewController:webController
										 animated:YES];
	
	return self;
}

@end
