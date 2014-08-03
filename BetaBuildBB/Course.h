//
//  Course.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/2/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeetUp, User;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * professor;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSSet *students;
@property (nonatomic, retain) NSSet *meetingsForCourse;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(User *)value;
- (void)removeStudentsObject:(User *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

- (void)addMeetingsForCourseObject:(MeetUp *)value;
- (void)removeMeetingsForCourseObject:(MeetUp *)value;
- (void)addMeetingsForCourse:(NSSet *)values;
- (void)removeMeetingsForCourse:(NSSet *)values;

//Copy and paste these methods if you overwrite MO's
+(instancetype)courseWithContext:(NSManagedObjectContext *)context; 

@end
