//
//  BBPickUniversityViewController.m
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/16/14.
//
//

#import "BBPickUniversityViewController.h"
#import "BBMeetupLocationDataStore.h"
#import "BBPickClassViewController.h"
#import "BBUniversity.h"

@interface BBPickUniversityViewController ()

@property (strong, nonatomic) IBOutlet UIPickerView *universityPicker;

@end

@implementation BBPickUniversityViewController

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
    self.universityPicker.dataSource = self;
    self.universityPicker.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataStore.allUniversitiesArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    BBUniversity *univerisity = self.dataStore.allUniversitiesArray[row];
    self.chosenUniversity = self.dataStore.allUniversitiesArray[row];
    return univerisity.name;
}


#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
        self.chosenUniversity = self.dataStore.allUniversitiesArray[row];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBPickClassViewController *newVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"universitySelected"]) {
        newVC.chosenUniversity = self.chosenUniversity;
    }
}


@end
