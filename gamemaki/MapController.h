//
//  MapController.h
//  gamemaki
//
//  Created by Socialico on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MapController : UIViewController
<MKMapViewDelegate> {
    MKMapView* mapView;
}

@property (nonatomic, retain) MKMapView *mapView;

@end
