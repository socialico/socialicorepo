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
        TTStyledText* styledText = [TTStyledText textFromXHTML:
									[NSString stringWithFormat:@"%@\n<b>%@</b>",
									[[challenge.challengeTitle stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]
                                      stringByReplacingOccurrencesOfString:@"<"
                                      withString:@"&lt;"],
									[challenge.createdAt formatRelativeTime]]
									lineBreaks:YES URLs:YES];
        // If this asserts, it's likely that the tweet.text contains an HTML character that caused
        // the XML parser to fail.
        TTDASSERT(nil != styledText);
        [items addObject:[TTTableStyledTextItem itemWithText:styledText]];
    }
    
    if (!_searchFeedModel.finished) {
        [items addObject:[TTTableMoreButton itemWithText:@"more…"]];
    }
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating Twitter feed...", @"Twitter feed updating text");
    } else {
        return NSLocalizedString(@"Loading Twitter feed...", @"Twitter feed loading text");
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No tweets found.", @"Twitter feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the Twitter stream.", @"");
}


@end
