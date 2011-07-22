//
//  HomeController.m
//  gamemaki
//
//  Created by Socialico on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSON.h"
#import "gamemakiAppDelegate.h"
#import "GlobalStore.h"
#import "User.h"

@implementation LoginController


- (void)loadView {
	[super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];
    
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default_2nd.png"]]];

    //self.navigationController.navigationBar.hidden = YES;
    
    _fbLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_fbLoginBtn setTitle:@"Login with your Facebook" forState:UIControlStateNormal];
    [_fbLoginBtn addTarget:self action:@selector(fbLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_fbLoginBtn sizeToFit];
    _fbLoginBtn.top = 400;
    _fbLoginBtn.left = floor(self.view.width/2 - _fbLoginBtn.width/2);
    [self.view addSubview:_fbLoginBtn];
    
    _loadingLabel = [[[TTStyledTextLabel alloc] initWithFrame:CGRectMake(0, 0, 110, 30)] autorelease];
    _loadingLabel.font = [UIFont  boldSystemFontOfSize:24];
    _loadingLabel.text = [TTStyledText textFromXHTML:@"loading..." lineBreaks:NO URLs:NO];
    _loadingLabel.top = 400;
    _loadingLabel.left = floor(self.view.width/2 - _loadingLabel.width/2);
	_loadingLabel.textColor = [UIColor whiteColor];
	_loadingLabel.backgroundColor = [UIColor clearColor];
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
    
    //retrieve user data from facebook response
    NSString* userId = [result objectForKey:@"id"];
    NSString* userName = [result objectForKey:@"name"];
    NSString* userEmail = [result objectForKey:@"email"];
    NSString* userGender = [result objectForKey:@"gender"];
    NSString* userBirthday = [result objectForKey:@"birthday"];
    NSLog(@"userId = %@",userId);
    NSLog(@"userName = %@",userName);
    NSLog(@"userEmail = %@",userEmail);
    NSLog(@"userGender = %@",userGender);
    NSLog(@"userBirthday = %@",userBirthday);
    
	//construct new request param
	NSDictionary* newAuthToken = [[NSDictionary alloc] initWithObjectsAndKeys:userId,@"id",userName,@"name",
                                  userEmail,@"email",userBirthday,@"birthday",userGender,@"gender",nil];
	
	//convert request param into JSON string
	NSString* json = [newAuthToken JSONRepresentation];
    NSString* escapedJson = [json stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSString* url = [@"http://www.gamemaki.com/main/handshake?token=" stringByAppendingString:escapedJson];

    //request for user data from own server using facebook user id
    TTURLRequest* getSecretRequest = [TTURLRequest request];
    getSecretRequest.response = [[TTURLJSONResponse alloc] init];
	getSecretRequest.urlPath = url;
    [getSecretRequest sendSynchronously];
    
    //retrieve secret key from response
    TTURLJSONResponse* getSecretResponse = getSecretRequest.response;
    NSDictionary* jsonResponse = getSecretResponse.rootObject;
	NSLog(@"jsonResponse = %@", jsonResponse);
    NSString* secretKey = [jsonResponse objectForKey:@"secret"];
    NSLog(@"secret key = %@", secretKey);
	
    //should reset instead of adding new secret
    [self addSecretKeyAndId:secretKey:userId];
    
    //request for session key from own server
    TTURLRequest* getSessionKeyRequest = [TTURLRequest request];
    getSessionKeyRequest.response = [[TTURLJSONResponse alloc] init];
	getSessionKeyRequest.urlPath = [@"http://www.gamemaki.com/main/createSession?secretKey=" stringByAppendingFormat:@"%@%@%@", secretKey, @"&facebookId=", userId];
    [getSessionKeyRequest sendSynchronously];
    
    //retrieve session key from response
    TTURLJSONResponse* getSessionKeyResponse = getSessionKeyRequest.response;
    NSDictionary* jsonResponse2 = getSessionKeyResponse.rootObject;
	NSLog(@"jsonResponse2 = %@", jsonResponse2);
    NSString* sessionKey = [jsonResponse2 objectForKey:@"sessionKey"];
    NSLog(@"session key = %@", sessionKey);

    //save session key in memory
    GlobalStore* instance = [GlobalStore sharedInstance];
    instance.sessionKey = sessionKey;
	
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


- (void)addSecretKeyAndId:(NSString *)key :(NSString*)userId {
    gamemakiAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext* managedObjectContext = [appDelegate managedObjectContext];
    
    User* user = (User*)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
	[user setSecretKey:key];
    [user setFacebookId:userId];
    
	NSError *error;
    if(![managedObjectContext save:&error]){
	    //This is a serious error saying the record
	    //could not be saved. Advise the user to
	    //try again or restart the application. 
    }
}

@end
