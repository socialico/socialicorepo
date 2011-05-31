//
//  GlobalStore.m
//  gamemaki
//
//  Created by Socialico on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalStore.h"

@implementation GlobalStore

@synthesize categoryId = _categoryId;

+ (GlobalStore*)sharedInstance
{
    // the instance of this class is stored here
    static GlobalStore* myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        // initialize variables here
    }
    // return the instance of this class
    return myInstance;
}

- (void) addToChallengeList:(NSMutableArray*) array {
    //do something here
}

@end
