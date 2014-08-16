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

@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *twitterSwitch;

- (IBAction)logout:(id)sender;
- (IBAction)refreshButton:(id)sender;
- (IBAction)facebookSwitch:(UISwitch *)sender;
- (IBAction)twitterSwitch:(UISwitch *)sender;

//Located in category
- (IBAction)newMeetingLaterButton:(id)sender;


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
        _meetupToPass = [MeetUp meetUpWithContext:self.dataStore.managedObjectContext];
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
    [self.mapOutlet showsUserLocation];
    
    self.meetupArray = [NSMutableArray new];
    
    self.mapOutlet.delegate = self;
    self.mapOutlet.showsUserLocation = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
    
    [self plotMeetupOnMap:self.dataStore.userMeetup];

    [self checkForLoggedInUser];
    
    [self.dataStore fetchAllMeetUpsFromParse];
    [self.dataStore fetchUniversitiesFromParseWithCompletion:^{
        NSLog(@"all universities fetched");
    }];
    
    //Left Drawer Button
    self.leftBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.leftBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem  = self.leftBarButtonItem;
    
    //Right Drawer Button
    self.rightBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.rightBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem  = self.rightBarButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.currentUser = [PFUser currentUser];
    [self setTwitterSwitchState];
    [self setFacebookSwitchState];
}

- (void) setFacebookSwitchState
{
    if (![PFFacebookUtils isLinkedWithUser:self.currentUser]) {
        [self.facebookSwitch setOn:NO];
    } else {
        [self.facebookSwitch setOn:YES];
    }
}

- (void) setTwitterSwitchState
{
    if (![PFTwitterUtils isLinkedWithUser:self.currentUser]) {
        [self.twitterSwitch setOn:NO];
    } else {
        [self.twitterSwitch setOn:YES];
    }
}

- (IBAction)facebookSwitch:(UISwitch *)sender {
    if (sender.on == YES) {
        [self linkFacebook];
    } else if (sender.on == NO) {
        [self unlinkFacebook];
    }
}

- (IBAction)twitterSwitch:(UISwitch *)sender {
    if (sender.on == YES) {
        [self linkTwitter];
    } else if (sender.on == NO) {
        [self unlinkTwitter];
    }
}

#pragma mark - Social Media Methods
- (void)linkTwitter
{
    if (![PFTwitterUtils isLinkedWithUser:self.currentUser]) {
        [PFTwitterUtils linkUser:self.currentUser block:^(BOOL succeeded, NSError *error) {
            if ([PFTwitterUtils isLinkedWithUser:self.currentUser]) {
                NSLog(@"Woohoo, user logged in with Twitter!");
            }
        }];
    }
}

- (void)linkFacebook
{
    if (![PFFacebookUtils isLinkedWithUser:self.currentUser]) {
        [PFFacebookUtils linkUser:self.currentUser permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, user logged in with Facebook!");
            }
        }];
    }
}

- (void)unlinkTwitter
{
    [PFTwitterUtils unlinkUserInBackground:self.currentUser block:^(BOOL succeeded, NSError *error) {
        if (!error && succeeded) {
            NSLog(@"The user is no longer associated with their Twitter account.");
        }
    }];
}

- (void)unlinkFacebook
{
    [PFFacebookUtils unlinkUserInBackground:self.currentUser block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"The user is no longer associated with their Facebook account.");
        }
    }];
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
            MeetUp *meetingToPlot = [MeetUp makePFObjectintoMeetup:pfobject withManagedObjectContext:self.dataStore.managedObjectContext];
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

-(void)plotMeetupOnMap:(MeetUp *)meetUpToBePlotted
{
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    
    CGFloat latitudeFloat = [meetUpToBePlotted.latitude floatValue];
    CGFloat longitudeFloat = [meetUpToBePlotted.longitude floatValue];
    
    point.coordinate = CLLocationCoordinate2DMake(latitudeFloat, longitudeFloat);
    point.title = meetUpToBePlotted.meetingName;
    [self.mapOutlet addAnnotation:point];
}



-(void)plotAllMeetUpsOnMap:(NSArray *)arrayOfMeetups
{
    for (MeetUp *meetup in arrayOfMeetups)
    {
        [self plotMeetupOnMap:meetup];
    }
}

#pragma mark - STANDARD PARSE LOGIN METHODS
- (void) checkForLoggedInUser
{
    if (![PFUser currentUser]) {
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = [NSArray arrayWithObjects:@"email", nil];
        logInViewController.fields = PFLogInFieldsDefault | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsDismissButton;
        
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        signUpViewController.delegate = self;
        
        logInViewController.signUpController = signUpViewController;
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    } else {
        self.currentUser = [PFUser currentUser];
    }
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
    self.currentUser = user;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in with Error: %@...", error);
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
    //FIXME: avoid 'id' type
    for (NSString *key in info) {
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
    [self displayAlertWithError:error];
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}

- (void)displayAlertWithError:(NSError *)error {
    NSString *errorMessage = [NSString stringWithFormat:@"%@", error.localizedDescription];
    [self displayAlertWithMessage:errorMessage];
}

- (void)displayAlertWithMessage:(NSString *)errorMessage {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"The following error has occured" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
