//
//  BBCreateMeetingNowViewController.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 7/20/14.
//
//

#import "BBCreateMeetingNowViewController.h"

@interface BBCreateMeetingNowViewController ()
@property (weak, nonatomic) IBOutlet UITextField *meetupName;
@property (weak, nonatomic) IBOutlet UITextField *meetupClass;
@property (weak, nonatomic) IBOutlet UITextField *meetupActivity;
@property (weak, nonatomic) IBOutlet UITextField *meetupLocation;

@end

@implementation BBCreateMeetingNowViewController

- (IBAction)createNewMeetup:(id)sender
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    NSNumber *latitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.latitude];
    NSNumber *longitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.longitude];
    
    MeetUp *newMeetUp = [self.dataStore makeMeetUpObject];
    newMeetUp.userId = [NSString stringWithFormat:@"%@", [PFUser currentUser]];
    newMeetUp.meetingName = self.meetupName.text;
    newMeetUp.locationName = self.meetupLocation.text;
    newMeetUp.activityType = self.meetupActivity.text;
    newMeetUp.startTime = [NSDate date];
    newMeetUp.endTime = [[NSDate date] dateByAddingTimeInterval:60*60];
    newMeetUp.latitude = latitudeNumber;
    newMeetUp.longitude = longitudeNumber;
    
    self.dataStore.userMeetup = newMeetUp;

    [MeetUp createMeetupInParse:self.dataStore.userMeetup];
    [self.dataStore.meetUpsArray addObject:self.dataStore.userMeetup];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}




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

    self.dataStore = [BBMeetupLocationDataStore sharedDataStore];
    
    _passedMeetup = [MeetUp meetUpWithContext:self.dataStore.managedObjectContext]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)getCurrentLocation
//{
//    CLLocationManager *manager = [[CLLocationManager alloc]init];
//    
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.delegate = self;
//    
//    [self.locationManager startUpdatingLocation];
//    
//}


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
