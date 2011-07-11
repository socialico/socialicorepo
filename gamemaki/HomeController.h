//
//  HomeController.h
//  gamemaki
//
//  Created by Socialico on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import <UIKit/UIKit.h>

#import "FBConnect.h"

@interface HomeController : TTViewController
<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>{
    UIButton* _fbLoginBtn;
    TTStyledTextLabel* _loadingLabel;
}

-(IBAction)fbLoginBtnClick:(id)sender;

-(IBAction)fbLogoutBtnClick:(id)sender;

@end
