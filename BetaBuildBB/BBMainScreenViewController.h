//
//  BBMainScreenViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BBMainScreenViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;



@end
