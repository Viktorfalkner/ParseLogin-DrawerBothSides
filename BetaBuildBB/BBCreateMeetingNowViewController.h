//
//  BBCreateMeetingNowViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import "BBMeetup.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "BBMeetupLocationDataStore.h"

@interface BBCreateMeetingNowViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;


-(void)getCurrentLocation;


@end
