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
}

//@property(nonatomic, retain) UILabel* label;

-(IBAction)fbLoginBtnClick:(id)sender;

-(IBAction)fbLogoutBtnClick:(id)sender;

@end
