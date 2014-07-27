//
//  BBMeetup.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import "BBMeetup.h"

@implementation BBMeetup


- (instancetype)init
{
return [self initWithUserID:@""
                MeetingName:@""
           withLocationName:@""
              withStartTime:[NSDate date]
                withEndTime:[NSDate date]
                withLatidue:@0
              withLongitude:@0];
}

- (instancetype)initWithUserID:(NSString *)userID
                   MeetingName:(NSString *)meetingName
              withLocationName:(NSString *)locationName
                 withStartTime:(NSDate *)startTime
                   withEndTime:(NSDate *)endTime
                   withLatidue:(NSNumber *)latitude
                 withLongitude:(NSNumber *)longitude
{
    self = [super init];
    if (self) {
        _userID = userID;
        _meetingName = meetingName;
        _locationName = locationName;
        _startTime = startTime;
        _endTime = endTime;
        _latitude = latitude;
        _longitude = longitude;
        
    }
    return self;
}

+(void)createMeetupInParse:(BBMeetup *)newMeetupLocation
{
    PFObject *meetupLocationToStore = [PFObject objectWithClassName:@"BBMeetup"];
    CLLocationManager *manager = [[CLLocationManager alloc]init];
    
    newMeetupLocation.longitude = [NSNumber numberWithFloat:manager.location.coordinate.longitude];
    newMeetupLocation.latitude = [NSNumber numberWithFloat:manager.location.coordinate.latitude];
    
    PFUser *currentUser = [PFUser currentUser];
    
    meetupLocationToStore[@"userID"] = currentUser.objectId;
    meetupLocationToStore[@"meetingName"] = newMeetupLocation.meetingName;
    meetupLocationToStore[@"locationName"] = newMeetupLocation.locationName;
    meetupLocationToStore[@"startTime"] = newMeetupLocation.startTime;
    meetupLocationToStore[@"endTime"] = newMeetupLocation.endTime;
    meetupLocationToStore[@"longitudeValue"] = newMeetupLocation.longitude;
    meetupLocationToStore[@"latitudeValue"] = newMeetupLocation.latitude;
    
    [meetupLocationToStore saveInBackground];
}



@end
