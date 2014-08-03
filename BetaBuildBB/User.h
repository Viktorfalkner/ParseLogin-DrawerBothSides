//
//  User.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/2/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, MeetUp, User;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * hasMeeting;
@property (nonatomic, retain) NSNumber * hasCourse;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * university;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *meetings;
@property (nonatomic, retain) NSSet *friends;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addMeetingsObject:(MeetUp *)value;
- (void)removeMeetingsObject:(MeetUp *)value;
- (void)addMeetings:(NSSet *)values;
- (void)removeMeetings:(NSSet *)values;

- (void)addFriendsObject:(User *)value;
- (void)removeFriendsObject:(User *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

//Copy and paste these methods if you overwrite MO's
+(instancetype)userWithContext:(NSManagedObjectContext *)context; 

@end
