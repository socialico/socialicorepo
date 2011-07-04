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
    //IBOutlet UILabel* _label;
    Facebook* _facebook;
    NSArray* _permissions;
}

//@property(nonatomic, retain) UILabel* label;

@property(readonly) Facebook* facebook;

-(IBAction)fbLoginBtnClick:(id)sender;

-(IBAction)fbLogoutBtnClick:(id)sender;

@end
