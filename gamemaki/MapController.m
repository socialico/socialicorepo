//
//  MapController.m
//  gamemaki
//
//  Created by Socialico on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"

@implementation MapController

@synthesize locationManager, mapView;

- (id)initWithName:(NSString*) name {
    if (self == [super init]) {
        //Styling Properties
        UIImage *barLogo = [UIImage imageNamed:@"nav_bar_logo"];
        UIImageView *barLogoView = [[UIImageView alloc] initWithImage:barLogo];
        self.navigationItem.titleView = barLogoView;
        self.navigationController.navigationBar.tintColor = RGBCOLOR(41,41,41); //doesn't seems to work
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleBlackOpaque; //doesn't seems to work
        
        self.title = @"My Location";
        //self.variableHeightRows = YES;
        
        UIImage* image = [UIImage imageNamed:@"me.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
        
        self.locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        //[locationManager startUpdatingLocation];
    }
    return self;
}


- (void)dealloc
{
    [locationManager release];
    [mapView release];
    [super dealloc];
}


- (void)loadView {
	[super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, (self.view.height - 10))];
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
}


-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%g", 
                                 newLocation.coordinate.latitude];
    
    NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    
    NSLog(@"current latitude - %@", currentLatitude);
    NSLog(@"current longitude - %@", currentLongitude);
    
    [currentLatitude release];
    [currentLongitude release];
}

@end
