//
//  ChallengeFeedModel.m
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import "ChallengeFeedModel.h"

#import "Challenge.h"

#import "GlobalStore.h"

#import <extThree20JSON/extThree20JSON.h>

//Gamemaki Challenges API documented here:
static NSString* ChallengeFeed = @"http://gamemaki.com/main/api/challenges.json?cat_id=%@&limit=%u&page=%u";

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
    //NSLog(@"Response ----- %@", response.rootObject);
        
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
		
		//TEMPORARY: replace relative path with absolute path
		if([challenge.photoSmall isEqualToString:@"../../main/images/default_avatar.png"])
			challenge.photoSmall = [challenge.photoSmall stringByReplacingOccurrencesOfString:@"../.." 
														 withString:@"http://www.gamemaki.com"];
			
        challenge.userName = [entry objectForKey:@"userName"];
		challenge.categoryName = [entry objectForKey:@"categoryName"];
        
        [challengelist addObject:challenge];
        TT_RELEASE_SAFELY(challenge);
    }
    _finished = challengelist.count < _resultsPerPage;
    [_challengelist addObjectsFromArray: challengelist];
    
    [[GlobalStore sharedInstance] setCategoryId:@"gamemaki huat ah"];
    
    TT_RELEASE_SAFELY(dateFormatter);
    
    [super requestDidFinishLoad:request];
}


@end
