//
//  HomeController.m
//  gamemaki
//
//  Created by Socialico on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeController.h"
#import "GlobalStore.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation HomeController

- (void)loadView {
    [super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];
    
    self.navigationController.navigationBar.hidden = YES;
    
    _fbLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_fbLoginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [_fbLoginBtn addTarget:self action:@selector(fbLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_fbLoginBtn sizeToFit];
    _fbLoginBtn.top = 20;
    _fbLoginBtn.left = floor(self.view.width/2 - _fbLoginBtn.width/2);
    [self.view addSubview:_fbLoginBtn];
    
    _loadingLabel = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
    _loadingLabel.font = [UIFont  boldSystemFontOfSize:24];
    _loadingLabel.text = [TTStyledText textFromXHTML:@"loading..." lineBreaks:YES URLs:YES];
    _loadingLabel.top = 60;
    _loadingLabel.left = 100;
    [self.view addSubview:_loadingLabel];
}

/**
 * Set initial view
 */
- (void)viewDidLoad {
    [_loadingLabel setHidden:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
    [_fbLoginBtn release];
    [_loadingLabel release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/**
 * Show the authorization dialog.
 */
-(IBAction)fbLoginBtnClick:(id)sender {
    GlobalStore* instance = [GlobalStore sharedInstance];
    [instance.facebook authorize:instance.permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
-(IBAction)fbLogoutBtnClick:(id)sender {
    GlobalStore* instance = [GlobalStore sharedInstance];
    [instance.facebook logout:self];
}

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    NSLog(@"logged in");
    
    //request for user data (including userId) from facebook using facebook access token
    GlobalStore* instance = [GlobalStore sharedInstance];
    [instance.facebook requestWithGraphPath:@"me" andDelegate:self];
    
    //hide login button and show loading text
    [_fbLoginBtn setHidden:YES];
    [_loadingLabel setHidden:NO];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    NSLog(@"logged out");
    
    //show login button and hide loading text
    [_fbLoginBtn setHidden:NO];
    [_loadingLabel setHidden:YES];
}


////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
//- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
//    NSLog(@"received response");
//    NSLog(@"%@",response);
//}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"received result");
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    NSString* username = [result objectForKey:@"name"];
    NSString* userId = [result objectForKey:@"id"];
    NSString* userEmail = [result objectForKey:@"email"];
    NSLog(@"username = %@",username);
    NSLog(@"useri = %@",userId);
    NSLog(@"useremail = %@",userEmail);
    
    //request for user data from own server using facebook user id
    TTURLJSONResponse* gettokenresponse = [[TTURLJSONResponse alloc] init];
    TTURLRequest* gettokenrequest = [TTURLRequest request];
    
    gettokenrequest.response = gettokenresponse;
    //gettokenrequest.urlPath = @"http://gamemaki.com/main/api/handshake";
    gettokenrequest.urlPath = @"http://gamemaki.com/main/api/challenges.json?cat_id=1limit=10&page=1";
    //gettokenrequest.cachePolicy = cachePolicy;
    //gettokenrequest.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    [gettokenrequest sendSynchronously];
    
    TTURLJSONResponse* thetruth = gettokenrequest.response;
    NSLog(@"Response ----- %@", thetruth);
    NSLog(@"Response ----- %@", thetruth.rootObject);
    
    //open home menu
    TTOpenURL(@"tt://tabBar");
};


/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //[self.label setText:[error localizedDescription]];
};

@end
