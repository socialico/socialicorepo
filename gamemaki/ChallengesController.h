//
//  ChallengesController.h
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import <Three20/Three20.h>

@interface ChallengesController : TTTableViewController {
	NSString* _categoryId;
}

@property (nonatomic, copy)   NSString* categoryId;

@end
