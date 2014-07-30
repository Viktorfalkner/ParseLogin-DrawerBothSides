//
//  BBLoginRootViewController.m
//  BetaBuildBB
//
//  Created by Troy Barrett on 7/5/14.
//
//

#import "BBLoginRootViewController.h"
#import "BBCreateMeetingNowViewController.h"

@interface BBLoginRootViewController ()
- (IBAction)logout:(id)sender;

- (IBAction)refreshButton:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@end

@implementation BBLoginRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _meetupToPass = [[BBMeetup alloc]init];
    }
    return self;
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [BBMeetupLocationDataStore sharedDataStore];

    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager startUpdatingLocation];
    self.meetupArray = [NSMutableArray new];
    
    self.mapOutlet.delegate = self;
    self.mapOutlet.showsUserLocation = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.dataStore fetchAllMeetUpsFromParse];
    

    
//   [self plotMeetupOnMap:self.dataStore.userMeetup];
    
    if (![PFUser currentUser]) {
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        
        [logInViewController setSignUpController:signUpViewController];
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
    //Left Drawer Button
    self.leftBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.leftBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem  = self.leftBarButtonItem;
    
    //Right Drawer Button
    self.rightBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.rightBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem  = self.rightBarButtonItem;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self viewDidAppear:YES];
    
}

- (IBAction)refreshButton:(id)sender
{
    
    [self.mapOutlet removeAnnotations:self.mapOutlet.annotations];
    PFQuery *queryForALLLocations = [PFQuery queryWithClassName:@"BBMeetup"];
    [queryForALLLocations findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray *queryResults = objects;
        for (PFObject *pfobject in queryResults)
        {
            BBMeetup *meetingToPlot = [BBMeetup makePFObjectintoBBMeetup:pfobject];
            [self.meetupArray addObject:meetingToPlot];
            [self plotMeetupOnMap:meetingToPlot];
        }
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coord = self.mapOutlet.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1500.0, 1500.0);
    
    [self.mapOutlet setRegion:region animated:YES];
}

-(void)plotMeetupOnMap:(BBMeetup *)meetUpToBePlotted
{
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    
    CGFloat latitudeFloat = [meetUpToBePlotted.latitude floatValue];
    CGFloat longitudeFloat = [meetUpToBePlotted.longitude floatValue];
    
    point.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    point.title = meetUpToBePlotted.meetingName;
    [self.mapOutlet addAnnotation:point];
}



-(void)plotAllMeetUpsOnMap:(NSArray *)arrayOfBBMeetups
{
    for (BBMeetup *meetup in arrayOfBBMeetups)
    {
        [self plotMeetupOnMap:meetup];
    }
}




@end
