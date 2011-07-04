//
//  ChallengeProfileController.h
//  gamemaki
//
//  Created by Damon Widjaja on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "Challenge.h"

@interface ChallengeProfileController : TTTableViewController {
    Challenge* _challengeProfile;
}

@property (nonatomic, copy)   Challenge* challengeProfile;

@end
