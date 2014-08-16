//
//  BBPickClassViewController.h
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@class BBUniversity;
@class BBMeetupLocationDataStore;
@class BBClass;

@interface BBPickClassViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) BBMeetupLocationDataStore *dataStore;

@property (strong, nonatomic) BBUniversity *chosenUniversity;
@property (strong, nonatomic) BBClass *chosenClass;

@end
