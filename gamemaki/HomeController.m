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

- (void)loadView {
    [super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];

    self.navigationBarTintColor = RGBCOLOR(41,41,41);
    self.statusBarStyle = UIStatusBarStyleBlackOpaque;
    self.view.backgroundColor = RGBCOLOR(227,218,202);
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Login" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openURLFromButton) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.top = 20;
    button.left = floor(self.view.width/2 - button.width/2);
    [self.view addSubview:button];
}

- (void)openURLFromButton {
    NSLog(@"Write something...");
    NSLog(@"Write something...");
    NSLog(@"Write something...");
    NSLog(@"Write something...");
    [_facebook authorize:_permissions delegate:self];
    //[self login];
}

/**
 * Set initial view
 */
- (void)viewDidLoad {
    _facebook = [[Facebook alloc] initWithAppId:kAppId];
    //[self.label setText:@"Please log in"];
    _getUserInfoButton.hidden = YES;
    _getPublicInfoButton.hidden = YES;
    _publishButton.hidden = YES;
    _uploadPhotoButton.hidden = YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
    [_label release];
    [_getUserInfoButton release];
    [_getPublicInfoButton release];
    [_publishButton release];
    [_uploadPhotoButton release];
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
    [_facebook authorize:_permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_facebook logout:self];
}


/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    //[self.label setText:@"logged in"];
    _getUserInfoButton.hidden = NO;
    _getPublicInfoButton.hidden = NO;
    _publishButton.hidden = NO;
    _uploadPhotoButton.hidden = NO;
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
    //[self.label setText:@"Please log in"];
    _getUserInfoButton.hidden    = YES;
    _getPublicInfoButton.hidden   = YES;
    _publishButton.hidden        = YES;
    _uploadPhotoButton.hidden = YES;
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
    //[self.label setText:@"publish successfully"];
}

@end
