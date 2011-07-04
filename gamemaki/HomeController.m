//
//  HomeController.m
//  gamemaki
//
//  Created by Socialico on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeController.h"
#import "FBConnect.h"

// Your Facebook APP Id must be set before running this example
// See http://www.facebook.com/developers/createapp.php
// Also, your application must bind to the fb[app_id]:// URL
// scheme (substitue [app_id] for your real Facebook app id).
static NSString* kAppId = @"182894781749423";

@implementation HomeController

@synthesize facebook = _facebook;

- (void)loadView {
    NSLog(@"loading view");
    
    _facebook = [[Facebook alloc] initWithAppId:kAppId];
    _permissions = [[NSArray arrayWithObjects:@"read_stream", @"publish_stream", @"offline_access",nil] retain];
    
    [super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];

    self.navigationBarTintColor = RGBCOLOR(41,41,41);
    self.statusBarStyle = UIStatusBarStyleBlackOpaque;
    self.view.backgroundColor = RGBCOLOR(227,218,202);
    
    UIButton* fbLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fbLoginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [fbLoginBtn addTarget:self action:@selector(fbLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fbLoginBtn sizeToFit];
    fbLoginBtn.top = 20;
    fbLoginBtn.left = floor(self.view.width/2 - fbLoginBtn.width/2);
    [self.view addSubview:fbLoginBtn];
    
    UIButton* fbLogoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fbLogoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [fbLogoutBtn addTarget:self action:@selector(fbLogoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fbLogoutBtn sizeToFit];
    fbLogoutBtn.top = 120;
    fbLogoutBtn.left = floor(self.view.width/2 - fbLogoutBtn.width/2);
    [self.view addSubview:fbLogoutBtn];
}

-(IBAction)fbLoginBtnClick:(id)sender {
    NSLog(@"showing login dialog box");
    [_facebook authorize:_permissions delegate:self];
    //[self login];
}

-(IBAction)fbLogoutBtnClick:(id)sender {
    NSLog(@"logging out");
    [_facebook logout:self];
}

/**
 * Set initial view
 */
- (void)viewDidLoad {
    //[self.label setText:@"Please log in"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
    //[_label release];
    [_facebook release];
    [_permissions release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/**
 * Show the authorization dialog.
 */
- (void)login {
    NSLog(@"showing login dialog box");
    [_facebook authorize:_permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    NSLog(@"logging out");
    [_facebook logout:self];
}

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    NSLog(@"logged in");
    //[self.label setText:@"logged in"];
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
    //[self.label setText:@"Please log in"];
}


////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
}

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
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    if ([result objectForKey:@"owner"]) {
        //[self.label setText:@"Photo upload Success"];
    } else {
        //[self.label setText:[result objectForKey:@"name"]];
    }
    NSLog(@"%@",result);
};

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //[self.label setText:[error localizedDescription]];
};


////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
    NSLog(@"redirected back from dialog box");
    //[self.label setText:@"publish successfully"];
}

@end
