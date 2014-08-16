//
//  BBMeetupReasonViewController.h
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/16/14.
//
//

#import <UIKit/UIKit.h>
@class BBClass;
@class BBUniversity;

@interface BBMeetupReasonViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) BBUniversity *chosenUniversity;
@property (strong, nonatomic) BBClass *chosenClass;
@property (strong, nonatomic) NSString *chosenActivity;

@end
