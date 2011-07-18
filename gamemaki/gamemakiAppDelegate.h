//
//  gamemakiAppDelegate.h
//  gamemaki
//
//  Created by Damon Widjaja on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Three20/Three20.h>
#import "HomeController.h"

@interface gamemakiAppDelegate : NSObject <UIApplicationDelegate> {
    HomeController* controller;
	NSManagedObjectModel* managedObjectModel;
	NSManagedObjectContext* managedObjectContext;	    
	NSPersistentStoreCoordinator* persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

- (NSMutableArray*)fetchRecords:(NSString*)entityName :(NSString*)attributeName;

//@property (nonatomic, retain) IBOutlet UIWindow *window;

@end