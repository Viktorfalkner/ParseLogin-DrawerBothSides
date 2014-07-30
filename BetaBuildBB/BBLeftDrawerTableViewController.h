//
//  BBLeftDrawerTableViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import "BBMeetupLocationDataStore.h"

@interface BBLeftDrawerTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *leftDrawerOptions;

@property (strong, nonatomic) BBMeetupLocationDataStore *dataStore;

@end
