//
//  BBMainScreenViewController.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import "BBMainScreenViewController.h"
#import "BBMeetupLocationDataStore.h"

@interface BBMainScreenViewController ()


@end

@implementation BBMainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    BBMeetupLocationDataStore *store = [BBMeetupLocationDataStore sharedDataStore];

    [self plotAllMeetUpsOnMap:store.meetUpsArray];
 
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)plotMeetupOnMap:(BBMeetup *)meetUpToBePlotted
{
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    
    double longitudeDouble = [meetUpToBePlotted.longitude doubleValue];
    double latitudeDouble = [meetUpToBePlotted.latitude doubleValue];
    
    point.coordinate = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble);
    point.title = meetUpToBePlotted.userID;
    point.subtitle = meetUpToBePlotted.meetingName;
    [self.mapOutlet addAnnotation:point];
}
-(void)plotAllMeetUpsOnMap:(NSArray *)arrayOfMeetups
{
    for (BBMeetup *meetup in arrayOfMeetups)
    {
        [self plotMeetupOnMap:meetup];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
