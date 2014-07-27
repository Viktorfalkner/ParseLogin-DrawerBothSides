//
//  BBMeetupLocationDataStore.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import <Foundation/Foundation.h>

@interface BBMeetupLocationDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *meetUpsArray;

+ (instancetype)sharedDataStore;

-(instancetype)init;


@end
