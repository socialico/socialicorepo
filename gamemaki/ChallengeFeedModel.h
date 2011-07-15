//
//  ChallengeFeedModel.h
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//
#import <Three20/Three20.h>

@interface ChallengeFeedModel : TTURLRequestModel {
    NSString* _searchQuery;
    NSString* _sessionKey;
    
    NSMutableArray*  _challengelist;
    
    NSUInteger _page;             // page of search request
    NSUInteger _resultsPerPage;   // results per page, once the initial query is made
    
    // this value shouldn't be changed
    BOOL _finished;
}

@property (nonatomic, copy)     NSString*       searchQuery;
@property (nonatomic, copy)     NSString*       sessionKey;
@property (nonatomic, readonly) NSMutableArray* challengelist;
@property (nonatomic, assign)   NSUInteger      resultsPerPage;
@property (nonatomic, readonly) BOOL            finished;

- (id)initWithSearchQuery:(NSString*)searchQuery;
- (id)initWithSessionKey:(NSString*)sessionKey;

@end
