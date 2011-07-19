//
//  gamemakiAppDelegate.m
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <extThree20JSON/extThree20JSON.h>
#import "gamemakiAppDelegate.h"
#import "TabBarController.h"
#import "TabMenuController.h"
#import "ChallengesController.h"
#import "ChallengeProfileController.h"
#import "CommentsController.h"
#import "GlobalStore.h"
#import "User.h"

@implementation gamemakiAppDelegate

@synthesize managedObjectContext;

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
	[map from:@"tt://my/challengesList/" toViewController:[ChallengesController class]];
	[map from:@"tt://challengesList/(initWithCategoryId:)" toViewController:[ChallengesController class]];
	[map from:@"tt://challengeProfile/" toViewController:[ChallengeProfileController class] transition:UIViewAnimationTransitionFlipFromLeft];
    [map from:@"tt://commentsList/(initWithChallengeId:)" toViewController:[CommentsController class]];
    
    if (![navigator restoreViewControllers]) {
        //nothing to restore. load home (not logged in)
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://home"]];
    } else {
        UIViewController* parentController = navigator.topViewController.parentViewController;
        if (parentController != nil) {
            [parentController.navigationController setNavigationBarHidden:YES];
        }
        
        //1. get secret key from managed object
        NSMutableArray* records = [self fetchRecords:@"User":@"secretKey"];
        if ([records count] != 0) {
            User* user = [records objectAtIndex:0];
            NSString* secretKey = [user secretKey];
            NSString* facebookId = [user facebookId];
            NSLog(@"secretKey - %@", secretKey);
            NSLog(@"facebookId - %@", facebookId);

            //2. request for session key from own server
            TTURLRequest* getSessionKeyRequest = [TTURLRequest request];
            getSessionKeyRequest.response = [[TTURLJSONResponse alloc] init];
            getSessionKeyRequest.urlPath = [@"http://www.gamemaki.com/main/createSession?secretKey=" stringByAppendingFormat:@"%@%@%@", secretKey, @"&facebookId=", facebookId];
            [getSessionKeyRequest sendSynchronously];
            
            //retrieve session key from response
            TTURLJSONResponse* getSessionKeyResponse = getSessionKeyRequest.response;
            NSDictionary* jsonResponse2 = getSessionKeyResponse.rootObject;
            NSLog(@"jsonResponse2 = %@", jsonResponse2);
            NSString* sessionKey = [jsonResponse2 objectForKey:@"sessionKey"];
            NSLog(@"session key = %@", sessionKey);
            
            //3. store session key in global store
            GlobalStore* instance = [GlobalStore sharedInstance];
            instance.sessionKey = sessionKey;
        }
    }
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    NSLog(@"handing OpenURL");
//    return [[controller facebook] handleOpenURL:url];
//}

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
	NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }

    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
	NSLog(@"managedObjectModel initialized!");
    return managedObjectModel;
}


/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
	NSLog(@"managedObjectContext initialized!");
    return managedObjectContext;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"gamemaki.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (NSMutableArray*)fetchRecords:(NSString*)entityName :(NSString*)attributeName {
	// Define our table/entity to use
	NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
	
	// Setup the fetch request
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	[request setReturnsObjectsAsFaults:NO];
	[request setEntity:entity];
	
	// Define how we will sort the records
	NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attributeName ascending:NO];
	NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	
	// Fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
    [request release];
    
	if (!mutableFetchResults) {
		// Handle the error.
		// This is a serious error and should advise the user to restart the application
	}
    
    return mutableFetchResults;
}


- (void)dealloc
{
	[managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [super dealloc];
}

@end
