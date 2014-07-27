//
//  BBMainScreenViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BBMeetup.h"

@interface BBMainScreenViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) NSMutableArray *meetupArray;

-(void)plotAllMeetUpsOnMap:(NSArray *)arrayOfMeetups;

-(void)plotMeetupOnMap:(BBMeetup *)meetUpToBePlotted;




@end
