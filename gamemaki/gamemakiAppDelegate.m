//
//  gamemakiAppDelegate.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "gamemakiAppDelegate.h"
#import "TabBarController.h"
#import "TabMenuController.h"
#import "ChallengesController.h"
#import "ChallengeProfileController.h"
#import "CommentsController.h"
#import "HomeController.h"

@implementation gamemakiAppDelegate


//@synthesize window=_window;

- (void)applicationDidFinishLaunching:(UIApplication*)application 
{
    controller = [[HomeController alloc] init];
    
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    
    TTURLMap* map = navigator.URLMap;
    
    //Mapping tab bar
	[map from:@"*" toViewController:[TTWebController class]];
    [map from:@"tt://home" toViewController:controller];
	[map from:@"tt://tabBar/" toSharedViewController:[TabBarController class]];
    [map from:@"tt://menu/(initWithMenu:)" toSharedViewController:[TabMenuController class]];
	[map from:@"tt://challengesList/(initWithCategoryId:)" toViewController:[ChallengesController class]];
	[map from:@"tt://challengeProfile/" toViewController:[ChallengeProfileController class] transition:UIViewAnimationTransitionFlipFromLeft];
    [map from:@"tt://commentsList/(initWithChallengeId:)" toViewController:[CommentsController class]];
    
    if (![navigator restoreViewControllers]) {
        //Launch tab bar on load
        //[navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://home"]];
    }
}

//- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
//    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
//    return YES;
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"handing OpenURL");
    return [[controller facebook] handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    //[_window release];
    [super dealloc];
}

@end
