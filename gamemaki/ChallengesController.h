//
//  ChallengesController.h
//  GameMaki
//
//  Created by Alexey Titlyanov on 23.05.11.
//  Copyright 2011 Socialico. All rights reserved.
//

#import <Three20/Three20.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    ChallengesByUser,
    ChallengesByLocation,
    ChallengesByCategory
} ChallengesType;

@interface ChallengesController : TTTableViewController
<CLLocationManagerDelegate> {
    ChallengesType challengesType;
	NSString* _categoryId;
    NSString* _latlng;
    CLLocationManager* locationManager;
}

@property (nonatomic, copy) NSString* categoryId;
@property (nonatomic, copy) NSString* latlng;
@property (nonatomic, retain) CLLocationManager* locationManager;

@end
