//
//  BBCreateMeetingNowViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import "MeetUp.h"
#import <CoreLocation/CoreLocation.h>
#import "BBMeetupLocationDataStore.h"

@class BBUniversity;
@class BBClass;

@interface BBCreateMeetingNowViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) MeetUp *passedMeetup;
@property (strong, nonatomic) BBMeetupLocationDataStore *dataStore;

@property (strong, nonatomic) BBUniversity *chosenUniversity;
@property (strong, nonatomic) BBClass *chosenClass;
@property (strong, nonatomic) NSString *chosenActivity;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^locationOfNewMeeting)(CGFloat latitudeOfMeeting, CGFloat longitudeOfMeeting);

@end
