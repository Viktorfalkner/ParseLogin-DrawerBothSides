//
//  BBEventDetailViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/3/14.
//
//

#import <UIKit/UIKit.h>

@class BBMeetupLocationDataStore;

@interface BBEventDetailViewController : UIViewController

@property (strong, nonatomic) EKEvent *eventToDetail;

@end
