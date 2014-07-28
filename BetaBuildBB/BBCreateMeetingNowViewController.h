//
//  BBCreateMeetingNowViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import "BBMeetup.h"
#import <CoreLocation/CoreLocation.h>
#import "BBMeetupLocationDataStore.h"

@interface BBCreateMeetingNowViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) BBMeetup *passedMeetup;
@property (strong, nonatomic) BBMeetupLocationDataStore *dataStore;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^locationOfNewMeeting)(CGFloat latitudeOfMeeting, CGFloat longitudeOfMeeting);





@end
