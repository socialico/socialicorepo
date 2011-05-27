//
//  ChallengeProfileController.h
//  gamemaki
//
//  Created by Damon Widjaja on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface ChallengeProfileController : TTWebController {
    NSString* _challengeId;
}

@property (nonatomic, copy)   NSString* challengeId;

@end
