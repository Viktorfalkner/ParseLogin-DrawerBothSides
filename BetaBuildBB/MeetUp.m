//
//  MeetUp.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/2/14.
//
//

#import "MeetUp.h"
#import "Course.h"
#import "User.h"


@implementation MeetUp

@dynamic userId;
@dynamic meetingName;
@dynamic locationName;
@dynamic startTime;
@dynamic endTime;
@dynamic latitude;
@dynamic longitude;
@dynamic activityType;
@dynamic courseToStudy;
@dynamic classmates;

+(instancetype)meetUpWithContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MeetUp" inManagedObjectContext:context];
}

+(void)createMeetupInParse:(MeetUp *)newMeetupLocation
{
    //Don't forget to set relationships for Meetups (course and classmates)
    PFObject *meetupLocationToStore = [PFObject objectWithClassName:@"BBMeetup"];
    CLLocationManager *manager = [[CLLocationManager alloc]init];
    
    newMeetupLocation.longitude = [NSNumber numberWithFloat:manager.location.coordinate.longitude];
    newMeetupLocation.latitude = [NSNumber numberWithFloat:manager.location.coordinate.latitude];
    
    PFUser *currentUser = [PFUser currentUser];
    
    meetupLocationToStore[@"userID"] = currentUser.objectId;
    meetupLocationToStore[@"meetingName"] = newMeetupLocation.meetingName;
    meetupLocationToStore[@"locationName"] = newMeetupLocation.locationName;
    meetupLocationToStore[@"activityType"] = newMeetupLocation.activityType;
    meetupLocationToStore[@"startTime"] = newMeetupLocation.startTime;
    meetupLocationToStore[@"endTime"] = newMeetupLocation.endTime;
    meetupLocationToStore[@"longitudeValue"] = newMeetupLocation.longitude;
    meetupLocationToStore[@"latitudeValue"] = newMeetupLocation.latitude;
    meetupLocationToStore[@"course"] =  newMeetupLocation.courseToStudy;
    meetupLocationToStore[@"classmates"] = newMeetupLocation.classmates;
    
    //Saving in Parse not CD
    [meetupLocationToStore saveInBackground];
}

+(MeetUp *)makePFObjectintoMeetup:(PFObject *)objectFromParse withManagedObjectContext:(NSManagedObjectContext *)context
{
    MeetUp *newMeetup = [NSEntityDescription insertNewObjectForEntityForName:@"MeetUp" inManagedObjectContext:context];
    
    newMeetup.userId = objectFromParse[@"userID"];
    newMeetup.meetingName =  objectFromParse[@"meetingName"];
    newMeetup.locationName =  objectFromParse[@"locationName"];
    newMeetup.activityType = objectFromParse[@"activityType"];
    newMeetup.startTime = objectFromParse[@"startTime"];
    newMeetup.endTime = objectFromParse[@"endTime"];
    newMeetup.longitude = objectFromParse[@"longitudeValue"];
    newMeetup.latitude = objectFromParse[@"latitudeValue"];
    
    return newMeetup;
}

@end
