//
//  BBLoginRootViewController.h
//  BetaBuildBB
//
//  Created by Troy Barrett on 7/5/14.
//
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BBLoginRootViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *location;

@property (strong, nonatomic) MMDrawerBarButtonItem *leftBarButtonItem;
@property (strong, nonatomic) MMDrawerBarButtonItem *rightBarButtonItem;

@end
