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
    //NSString* _categoryId;
    //NSMutableArray*  _challengelist;
    Facebook* _facebook;
    NSArray* _permissions;
}

// message from which our instance is obtained
+ (GlobalStore *)sharedInstance;

//@property(nonatomic, assign) NSString* categoryId;
//@property(nonatomic, copy) NSMutableArray* challengeList;
@property(nonatomic, assign) Facebook* facebook;
@property(nonatomic, assign) NSArray* permissions;

@end