//
//  GlobalStore.m
//  gamemaki
//
//  Created by Socialico on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalStore.h"

// Your Facebook APP Id must be set before running this example
// See http://www.facebook.com/developers/createapp.php
// Also, your application must bind to the fb[app_id]:// URL
// scheme (substitue [app_id] for your real Facebook app id).
static NSString* kAppId = @"182894781749423";

@implementation GlobalStore

//@synthesize challengeList = _challengelist;
@synthesize facebook = _facebook;
@synthesize permissions = _permissions;
@synthesize sessionKey = _sessionKey;

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

- (id) init {
    self = [super init];
    _facebook = [[Facebook alloc] initWithAppId:kAppId];
    _permissions = [[NSArray arrayWithObjects:@"read_stream", @"publish_stream", @"offline_access",nil] retain];
    return self;
}

- (void) dealloc {
    [_facebook release];
    [_permissions release];
    [super dealloc];
}

@end
