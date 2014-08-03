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

@interface BBMeetupLocationDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *meetUpsArray;
@property (strong, nonatomic) MeetUp *userMeetup;

@property (strong, nonatomic) NSMutableArray *leftDrawerArray;
@property (strong, nonatomic) NSMutableArray *rightDrawerArray;
@property (strong, nonatomic) NSMutableArray *allMeetingsArray;

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedDataStore;
-(instancetype)init;
-(void)fetchAllMeetUpsFromParse;

//Making managed objects
-(User *)makeUserObject;
-(Course *)makeCourseObject;
-(MeetUp *)makeMeetUpObject;

@end
