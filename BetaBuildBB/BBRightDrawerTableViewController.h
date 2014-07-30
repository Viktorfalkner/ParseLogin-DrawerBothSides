//
//  BBRightDrawerTableViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import "BBMeetupLocationDataStore.h"
#import "UIViewController+MMDrawerController.h"

@interface BBRightDrawerTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *rightDrawerOptions;
@property (strong, nonatomic) BBMeetupLocationDataStore *dataStore;

@end
