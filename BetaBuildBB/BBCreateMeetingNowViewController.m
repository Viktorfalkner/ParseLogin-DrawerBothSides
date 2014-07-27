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
@property (weak, nonatomic) IBOutlet UITextField *meetupSubject;
@property (weak, nonatomic) IBOutlet UITextField *meetupStudyType;
@property (weak, nonatomic) IBOutlet UITextField *meetupLocation;




@end

@implementation BBCreateMeetingNowViewController

- (IBAction)createNewMeetup:(id)sender
{
    
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
    NSNumber *latitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.latitude];
    
    NSNumber *longitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.longitude];
    
    BBMeetup *newMeetup = [[BBMeetup alloc]
                           initWithUserID:[NSString stringWithFormat:@"%@",[PFUser currentUser]]
                           MeetingName:self.meetupName.text
                           withLocationName:self.meetupLocation.text
                           withStartTime:[NSDate date]
                           withEndTime:[NSDate date]
                           withLatidue:latitudeNumber
                           withLongitude:longitudeNumber];
    
    [BBMeetup createMeetupInParse:newMeetup];
    
    
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
