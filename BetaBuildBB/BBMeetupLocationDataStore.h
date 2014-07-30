//
//  BBMeetupLocationDataStore.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import <Foundation/Foundation.h>
#import "BBMeetup.h"

@interface BBMeetupLocationDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *meetUpsArray;
@property (strong, nonatomic) BBMeetup *userMeetup;

@property (strong, nonatomic) NSMutableArray *leftDrawerArray;
@property (strong, nonatomic) NSMutableArray *rightDrawerArray;
@property (strong, nonatomic) NSMutableArray *allMeetingsArray;


+ (instancetype)sharedDataStore;
-(instancetype)init;
//-(void)fetchAllMeetingsFromParse:(void(^)())completionBlock;

-(void)fetchAllMeetUpsFromParse;

@end
