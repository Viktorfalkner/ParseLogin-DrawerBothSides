//
//  BBFutureMeetingsTableViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/3/14.
//
//

#import <UIKit/UIKit.h>

@class BBMeetupLocationDataStore;

@interface BBFutureMeetingsTableViewController : UITableViewController <CLLocationManagerDelegate, EKEventEditViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BBMeetupLocationDataStore *store;
@property (strong, nonatomic) EKEvent *futureMeetup;

//EKEventStore instance associated with
@property (strong, nonatomic) EKEventStore *eventStore;

//Default calendar associated with the event store
@property (strong, nonatomic) EKCalendar *userCalendar;

// Array of all user's events
@property (strong, nonatomic) NSMutableArray *eventsList;

@end
