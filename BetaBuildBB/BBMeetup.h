//
//  BBMeetup.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BBMeetup : NSObject

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *meetingName;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *activityType;



-(instancetype)init;

- (instancetype)initWithUserID:(NSString *)userID
                   MeetingName:(NSString *)meetingName
              withLocationName:(NSString *)locationName
                 withClassName:(NSString *)className
              withActivityType:(NSString *)activityType
                 withStartTime:(NSDate *)startTime
                   withEndTime:(NSDate *)endTime
                   withLatidue:(NSNumber *)latitude
                 withLongitude:(NSNumber *)longitude;


+(void)createMeetupInParse:(BBMeetup *)newMeetupLocation;







@end
