//
//  HomeController.h
//  gamemaki
//
//  Created by Socialico on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

#import "FBConnect.h"

@interface HomeController : TTViewController
<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate>{
    IBOutlet UILabel* _label;
    IBOutlet UIButton* _getUserInfoButton;
    IBOutlet UIButton* _getPublicInfoButton;
    IBOutlet UIButton* _publishButton;
    IBOutlet UIButton* _uploadPhotoButton;
    Facebook* _facebook;
    NSArray* _permissions;
}

@property(nonatomic, retain) UILabel* label;

@property(readonly) Facebook *facebook;

-(IBAction)fbButtonClick:(id)sender;

-(IBAction)getUserInfo:(id)sender;

-(IBAction)getPublicInfo:(id)sender;

-(IBAction)publishStream:(id)sender;

-(IBAction)uploadPhoto:(id)sender;


@end
