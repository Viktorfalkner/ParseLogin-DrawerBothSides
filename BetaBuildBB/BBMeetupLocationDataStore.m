//
//  BBMeetupLocationDataStore.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/26/14.
//
//

#import "BBMeetupLocationDataStore.h"

@implementation BBMeetupLocationDataStore


+ (instancetype)sharedDataStore {
    static BBMeetupLocationDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[BBMeetupLocationDataStore alloc]init];
    });
    
    return _sharedDataStore;
}


@end
