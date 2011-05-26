//
//  Challenge.m
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import "Challenge.h"


@implementation Challenge

@synthesize challengeId   = _challengeId;
@synthesize challengeTitle = _challengeTitle;
@synthesize placeId = _placeId;
@synthesize claimNo = _claimNo;
@synthesize commentNo = _commentNo;
@synthesize likeNo = _likeNo;
@synthesize dislikeNo = _dislikeNo;
@synthesize updatedAt = _updatedAt;
@synthesize createdAt = _createdAt;
@synthesize repeat = _repeat;
@synthesize hide = _hide;

@synthesize userId = _userId;
@synthesize userName = _userName;
@synthesize photoSmall = _photoSmall;
@synthesize photoLarge = _photoLarge;

@synthesize categoryId = _categoryId;
@synthesize categoryIcon = _categoryIcon;
@synthesize categoryName = _categoryName;

@synthesize accepted = _accepted;
@synthesize claimed = _claimed;
@synthesize claimedWithPhoto = _claimedWithPhoto;
@synthesize claimPhoto = _claimPhoto;
@synthesize repeatNo = _repeatNo;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
    TT_RELEASE_SAFELY(_challengeId);
    TT_RELEASE_SAFELY(_challengeTitle);
    TT_RELEASE_SAFELY(_placeId);
    TT_RELEASE_SAFELY(_claimNo);
    TT_RELEASE_SAFELY(_commentNo);
    TT_RELEASE_SAFELY(_likeNo);
    TT_RELEASE_SAFELY(_dislikeNo);  
    TT_RELEASE_SAFELY(_updatedAt);
    TT_RELEASE_SAFELY(_createdAt);
    TT_RELEASE_SAFELY(_repeat);
    TT_RELEASE_SAFELY(_hide);

    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_userName);
    TT_RELEASE_SAFELY(_photoSmall);
    TT_RELEASE_SAFELY(_photoLarge);

    TT_RELEASE_SAFELY(_categoryId);
    TT_RELEASE_SAFELY(_categoryIcon);
    TT_RELEASE_SAFELY(_categoryName);
    
    TT_RELEASE_SAFELY(_accepted);
    TT_RELEASE_SAFELY(_claimed);
    TT_RELEASE_SAFELY(_claimedWithPhoto);
    TT_RELEASE_SAFELY(_claimPhoto);
    TT_RELEASE_SAFELY(_repeatNo);

    
    [super dealloc];
}


@end
