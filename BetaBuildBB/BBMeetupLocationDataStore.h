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


+ (instancetype)sharedDataStore;

-(instancetype)init;


@end
