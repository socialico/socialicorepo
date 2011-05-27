//
//  ChallengesController.m
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import "ChallengesDataSource.h"
#import "ChallengeFeedModel.h"
#import "Challenge.h"

// Three20 Additions
#import <Three20Core/NSDateAdditions.h>


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ChallengesDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString*)searchQuery {
    if (self == [super init]) {
        _searchFeedModel = [[ChallengeFeedModel alloc] initWithSearchQuery:searchQuery];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    TT_RELEASE_SAFELY(_searchFeedModel);
    
    [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
    return _searchFeedModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (Challenge* challenge in _searchFeedModel.challengelist) {
        //TTDPRINT(@"Response text: %@", response.text);
		
		//Compose challenge profile URL
		NSString* challengeUrl = [NSString stringWithFormat:@"http://www.gamemaki.com/main/challenge_m?id=%u", challenge.challengeId];
		
        // If this asserts, it's likely that the tweet.text contains an HTML character that caused
        // the XML parser to fail.
        [items addObject:[TTTableMessageItem itemWithTitle:challenge.userName caption:challenge.categoryName 
												text:challenge.challengeTitle 
												timestamp:challenge.createdAt
												imageURL:challenge.photoSmall
												URL:challengeUrl]];
		
    }
    
    if (!_searchFeedModel.finished) {
        [items addObject:[TTTableMoreButton itemWithText:@"more challenges…"]];
    }
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Challenges...", @"Challenges feed updating text");
    } else {
        return NSLocalizedString(@"Loading Challenges...", @"Challenges feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No Challenges found.", @"Challenges feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the Challenges.", @"");
}


@end
