//
//  GlobalStore.h
//  gamemaki
//
//  Created by Socialico on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalStore : NSObject
{
    // Place any "global" variables here
    NSString* _categoryId;
}

// message from which our instance is obtained
+ (GlobalStore *)sharedInstance;

- (void) addToChallengeList:(NSMutableArray*) array;

@property(nonatomic, assign) NSString* categoryId;

@end