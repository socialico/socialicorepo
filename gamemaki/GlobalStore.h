//
//  GlobalStore.h
//  gamemaki
//
//  Created by Socialico on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface GlobalStore : NSObject
{
    // Place any "global" variables here
    //NSMutableArray*  _challengelist;
    Facebook* _facebook;
    NSArray* _permissions;
    NSString* _sessionKey;
}

// message from which our instance is obtained
+ (GlobalStore *)sharedInstance;

//@property(nonatomic, copy) NSMutableArray* challengeList;
@property(nonatomic, assign) Facebook* facebook;
@property(nonatomic, assign) NSArray* permissions;
@property(nonatomic, assign) NSString* sessionKey;

@end