//
//  CommentsController.h
//  gamemaki
//
//  Created by Socialico on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>


@interface CommentsController : TTTableViewController {
    NSString* _challengeId;
}

@property (nonatomic, copy)   NSString* challengeId;

@end
