//
//  MapController.m
//  gamemaki
//
//  Created by Socialico on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"

@implementation MapController


- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {

    if (self == [super initWithNavigatorURL:URL query:query]) {
        
        //setup navigation bar
        UIImage *barLogo = [UIImage imageNamed:@"nav_bar_logo"];
        UIImageView *barLogoView = [[UIImageView alloc] initWithImage:barLogo];
        self.navigationItem.titleView = barLogoView;
        self.navigationController.navigationBar.tintColor = RGBCOLOR(41,41,41); //doesn't seems to work
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleBlackOpaque; //doesn't seems to work
        self.title = @"My Location";
        
        //setup tab bar item
        UIImage* image = [UIImage imageNamed:@"me.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    }
    return self;
}


- (void)dealloc
{
    [mapView release];
    [super dealloc];
}


- (void)loadView {
	[super loadView];
    //[super viewWillAppear:NO];
    //[super viewDidAppear:NO];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, (self.view.height - 10))];
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
}

@end
