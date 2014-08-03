//
//  MeetUp.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/2/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, User;

@interface MeetUp : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * meetingName;
@property (nonatomic, retain) NSString * locationName;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) Course *courseToStudy;
@property (nonatomic, retain) NSSet *classmates;
@end

@interface MeetUp (CoreDataGeneratedAccessors)

- (void)addClassmatesObject:(User *)value;
- (void)removeClassmatesObject:(User *)value;
- (void)addClassmates:(NSSet *)values;
- (void)removeClassmates:(NSSet *)values;

//Copy and paste these methods if you overwrite MO's
+(instancetype)meetUpWithContext:(NSManagedObjectContext *)context;
+(void)createMeetupInParse:(MeetUp *)newMeetupLocation;
+(MeetUp *)makePFObjectintoMeetup:(PFObject *)objectFromParse withManagedObjectContext:(NSManagedObjectContext *)context;


@end
