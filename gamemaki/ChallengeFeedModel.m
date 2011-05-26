//
//  ChallengeFeedModel.m
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import "ChallengeFeedModel.h"

#import "Challenge.h"

#import <extThree20JSON/extThree20JSON.h>

// Twitter search API documented here:
// http://apiwiki.twitter.com/w/page/22554756/Twitter-Search-API-Method:-search
static NSString* ChallengeFeed = @"http://gamemaki.com/main/api/challenges.json";
//  @"http://192.168.2.108/~AlexTitle/challenges.json";


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ChallengeFeedModel

@synthesize searchQuery     = _searchQuery;
@synthesize challengelist   = _challengelist;
@synthesize resultsPerPage  = _resultsPerPage;
@synthesize finished        = _finished;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString*)searchQuery {
    if (self == [super init]) {
        self.searchQuery = searchQuery;
        _resultsPerPage = 10;
        _page = 1;
        _challengelist = [[NSMutableArray array] retain];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
    TT_RELEASE_SAFELY(_searchQuery);
    TT_RELEASE_SAFELY(_challengelist);
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading && TTIsStringWithAnyText(_searchQuery)) {
        if (more) {
            _page++;
        }
        else {
            _page = 1;
            _finished = NO;
            [_challengelist removeAllObjects];
        }
        
        NSString* url = [NSString stringWithFormat:ChallengeFeed, _searchQuery, _resultsPerPage, _page];
        
        TTURLRequest* request = [TTURLRequest
                                 requestWithURL: url
                                 delegate: self];
        
        request.cachePolicy = cachePolicy;
        request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
        
        TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
        request.response = response;
        TT_RELEASE_SAFELY(response);
        
        [request send];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLJSONResponse* response = request.response;
    NSLog(@"Response ----- %@", response.rootObject);
        
    NSArray* feed = response.rootObject;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    
    NSMutableArray* challengelist = [NSMutableArray arrayWithCapacity:[feed count]];
    
    for (NSDictionary* entry in feed) {
        Challenge* challenge = [[Challenge alloc] init];
        
        NSDate* date = [dateFormatter dateFromString:[entry objectForKey:@"createdAt"]];
        challenge.createdAt = date;
        challenge.challengeId = [NSNumber numberWithLongLong:
                         [[entry objectForKey:@"id"] longLongValue]];
        
        challenge.challengeTitle = [entry objectForKey:@"title"];
        challenge.photoSmall = [entry objectForKey:@"photoSmall"];
        challenge.userName = [entry objectForKey:@"userName"];
        
        
        [challengelist addObject:challenge];
        TT_RELEASE_SAFELY(challenge);
    }
    _finished = challengelist.count < _resultsPerPage;
    [_challengelist addObjectsFromArray: challengelist];
    
    TT_RELEASE_SAFELY(dateFormatter);
    
    [super requestDidFinishLoad:request];
}


@end
