//
//  BBMeetupLocationDataStore.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import <Foundation/Foundation.h>

@class User;
@class Course;
@class MeetUp;

@class BBUniversity;

@interface BBMeetupLocationDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *meetUpsArray;
@property (strong, nonatomic) MeetUp *userMeetup;

@property (strong, nonatomic) NSMutableArray *leftDrawerArray;
@property (strong, nonatomic) NSMutableArray *rightDrawerArray;
@property (strong, nonatomic) NSMutableArray *allMeetingsArray;
@property (strong, nonatomic) NSMutableArray *allUniversitiesArray;
@property (strong, nonatomic) NSMutableArray *selectedUniversityClasses;

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedDataStore;
-(instancetype)init;
-(void)fetchAllMeetUpsFromParse;

-(void)fetchClassesForUniversity:(BBUniversity *)university FromParse:(void (^)(void))classesFetched;
-(void)fetchUniversitiesFromParseWithCompletion:(void (^)(void))universitiesFetched;


//Making managed objects
-(User *)makeUserObject;
-(Course *)makeCourseObject;
-(MeetUp *)makeMeetUpObject;

@end
