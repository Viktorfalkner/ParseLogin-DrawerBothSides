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
    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager startUpdatingLocation];
    
    self.mapOutlet.delegate = self;
    self.mapOutlet.showsUserLocation = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.dataStore = [BBMeetupLocationDataStore sharedDataStore];
    [self showMeetingLocation];
    [self plotMeetupOnMap:self.dataStore.userMeetup]; 
    
    
    
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

#pragma mark - PFLoginViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}

#pragma mark - Left Button
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

#pragma mark - Right Button
-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self viewDidAppear:YES];

}

- (IBAction)refreshButton:(id)sender
{

    CLLocation *locationToDisplay = [self.locationManager location];
    
    MKPointAnnotation *pointOnMap = [[MKPointAnnotation alloc]init];
    
    pointOnMap.coordinate = locationToDisplay.coordinate;
 
    
//  pointOnMap.coordinate = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    NSLog(@"LAT :%f, LONG: %f",self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    [self.mapOutlet addAnnotation:pointOnMap];
    
    [self.mapOutlet setCenterCoordinate:pointOnMap.coordinate animated:YES];
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
    
    double longitudeDouble = [meetUpToBePlotted.longitude doubleValue];
    double latitudeDouble = [meetUpToBePlotted.latitude doubleValue];
    
    point.coordinate = CLLocationCoordinate2DMake(latitudeDouble, longitudeDouble);
    point.title = meetUpToBePlotted.userID;
    point.subtitle = meetUpToBePlotted.meetingName;
    [self.mapOutlet addAnnotation:point];
}


-(void)plotAllMeetUpsOnMap:(NSArray *)arrayOfMeetups
{
    if (self.dataStore.meetUpsArray == nil)
    {
        PFQuery *meetings = [PFQuery queryWithClassName:@"BBMeetup"];
        
        [meetings findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSArray *meetups = objects;
            for (BBMeetup *meetup in meetups)
            {
                [self.dataStore.meetUpsArray addObject:meetups];
    
            }
            [self plotAllMeetUpsOnMap:self.dataStore.meetUpsArray];
            NSLog(@"%@",self.dataStore.meetUpsArray);
        }];
        [self.mapOutlet reloadInputViews];
        
    }
//    PFQuery *query = [PFQuery queryWithClassName:@"BBMeetupLocation"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        _meetupsArray = objects;
//        [self.tableView reloadData];
//    }];

    for (BBMeetup *meetup in arrayOfMeetups)
    {
        [self plotMeetupOnMap:meetup];
    }
}
-(void)showMeetingLocation
{
    BBCreateMeetingNowViewController *createNowVC = [[BBCreateMeetingNowViewController alloc]init];
    
    createNowVC.locationOfNewMeeting = ^void(CGFloat latitudeOfMeeting, CGFloat longitudeOfMeeting)
    {
        MKPointAnnotation *newMeetingPoint = [[MKPointAnnotation alloc]init];
        newMeetingPoint.coordinate = CLLocationCoordinate2DMake(latitudeOfMeeting, longitudeOfMeeting);
        [self.mapOutlet addAnnotation:newMeetingPoint];
        [self.mapOutlet reloadInputViews];
        
    };
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}



@end
