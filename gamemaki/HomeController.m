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
#import "JSON.h"
#import <MobileCoreServices/UTCoreTypes.h>

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
    
    UIButton* cameraOpenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraOpenBtn setTitle:@"Take Photo" forState:UIControlStateNormal];
    [cameraOpenBtn addTarget:self action:@selector(cameraOpenClick:) forControlEvents:UIControlEventTouchUpInside];
    [cameraOpenBtn sizeToFit];
    cameraOpenBtn.top = 100;
    cameraOpenBtn.left = floor(self.view.width/2 - cameraOpenBtn.width/2);
    [self.view addSubview:cameraOpenBtn];
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

-(IBAction)cameraOpenClick:(id)sender {
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
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
    
    //retrieve secret from response and save it
    TTURLJSONResponse* getSecretResponse = getSecretRequest.response;
    NSDictionary* jsonResponse = getSecretResponse.rootObject;
	NSLog(@"jsonResponse = %@", jsonResponse);
    NSString* secret = [jsonResponse objectForKey:@"secret"];
    NSLog(@"secret = %@", secret);
    
    //open home menu
    //TTOpenURL(@"tt://tabBar");
};


/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //[self.label setText:[error localizedDescription]];
};


// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        // Save the new image (original or edited) to the Camera Roll
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    }
    
    // Handle a movie capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (
                                                 moviePath, nil, nil, nil);
        }
    }
    
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    //[picker release];
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {    
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    //[picker release];
}

@end
