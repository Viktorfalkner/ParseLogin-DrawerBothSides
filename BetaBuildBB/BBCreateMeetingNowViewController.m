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
    BBMeetupLocationDataStore *store = [BBMeetupLocationDataStore sharedDataStore];
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    NSNumber *latitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.latitude];
    
    NSNumber *longitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.longitude];
    
    BBMeetup *newMeetup = [[BBMeetup alloc]
                           initWithUserID:[NSString stringWithFormat:@"%@",[PFUser currentUser]]
                           MeetingName:self.meetupName.text
                           withLocationName:self.meetupLocation.text
                           withClassName:self.meetupClass.text
                           withActivityType:self.meetupActivity.text
                           withStartTime:[NSDate date]
                           withEndTime:[[NSDate date] dateByAddingTimeInterval:60*60]
                           withLatidue:latitudeNumber
                           withLongitude:longitudeNumber];
    
    [BBMeetup createMeetupInParse:newMeetup];
    
    [store.meetUpsArray addObject:newMeetup];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCurrentLocation
{
    CLLocationManager *manager = [[CLLocationManager alloc]init];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    
}

-(void)createANewMeetup
{

    
    
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
