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
- (instancetype)init
{
    self = [super init];
    if (self) {
        _meetUpsArray = [[NSMutableArray alloc]init];
        _leftDrawerArray = [[NSMutableArray alloc]init];
        _rightDrawerArray = [[NSMutableArray alloc]init];
        _allMeetingsArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)fetchAllMeetUpsFromParse
{
    PFQuery *queryMeetings = [PFQuery queryWithClassName:@"BBMeetup"];
    self.allMeetingsArray = [NSMutableArray new];
    self.leftDrawerArray = [NSMutableArray new];
    self.rightDrawerArray = [NSMutableArray new];
    
    [queryMeetings findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            for (PFObject *meetUpParseObject in objects)
            {
                //Add all meetups to fetched array
                BBMeetup *tempMeetUp = [BBMeetup makePFObjectintoBBMeetup:meetUpParseObject];
                           [self.allMeetingsArray addObject:tempMeetUp];
                
                if ([[[PFUser currentUser] objectId] isEqualToString:tempMeetUp.userID])
                {
                    [self.leftDrawerArray addObject:tempMeetUp];
                }
       
            }
            self.rightDrawerArray = self.allMeetingsArray;
            
        }
        else
        {
            NSLog(@"Parse error in datastore: %@", error.localizedDescription);
        }
    }];
}


//-(void)fetchAllMeetingsFromParse:(void(^)())completionBlock {
//    
//    PFQuery *allMeetings = [PFQuery queryWithClassName:@"BBMeetup"];
//    [allMeetings findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        NSLog(@"%@", error.localizedDescription);
//        for (PFObject *pfMeetup in objects)
//        {
//            BBMeetup *meetupToAdd = [BBMeetup makePFObjectintoBBMeetup:pfMeetup];
//            [self.allMeetingsArray addObject:meetupToAdd];
//        }
//        completionBlock();
//    }];
//}



@end
