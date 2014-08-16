//
//  BBPickUniversityViewController.h
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/16/14.
//
//

#import <UIKit/UIKit.h>
@class BBUniversity;

@class BBMeetupLocationDataStore;

@interface BBPickUniversityViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) BBMeetupLocationDataStore *dataStore;

@property (strong, nonatomic) BBUniversity *chosenUniversity;


@end
