//
//  ChallengeProfileController.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChallengeProfileController.h"

#import "GlobalStore.h"


@implementation ChallengeProfileController

@synthesize challengeId = _challengeId;

- (id)initWithChallengeId:(NSString*)challengeId {
	
	//Styling Properties
	self.navigationBarTintColor = RGBCOLOR(41,41,41);
	self.statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    NSString* testMessage = [[GlobalStore sharedInstance] categoryId];
    NSLog(@"Message - %@", testMessage);
    NSLog(@"Message - %@", testMessage);
    NSLog(@"Message - %@", testMessage);
    NSLog(@"Message - %@", testMessage);
    NSLog(@"Message - %@", testMessage);
	
    NSMutableArray* testMessage2 = [[GlobalStore sharedInstance] challengeList];
    NSLog(@"Message - %@", testMessage2);
    NSLog(@"Message - %@", testMessage2);
    NSLog(@"Message - %@", testMessage2);
    NSLog(@"Message - %@", testMessage2);
    NSLog(@"Message - %@", testMessage2);
    
	NSString* webchallengeUrl = [NSString stringWithFormat:@"http://m.gamemaki.com/main/challenge_m?id=%@", challengeId];
	TTOpenURL(webchallengeUrl);

	return self;
}

@end
