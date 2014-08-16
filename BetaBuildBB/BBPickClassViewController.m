//
//  BBPickClassViewController.m
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/16/14.
//
//

#import "BBPickClassViewController.h"
#import "BBMeetupLocationDataStore.h"
#import "BBCreateMeetingNowViewController.h"
#import "BBClass.h"

@interface BBPickClassViewController ()

@property (strong, nonatomic) IBOutlet UIPickerView *classPicker;

@end

@implementation BBPickClassViewController

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
    self.classPicker.dataSource = self;
    self.classPicker.delegate = self;
    self.dataStore = [BBMeetupLocationDataStore sharedDataStore];
    [self.dataStore fetchClassesForUniversity:self.chosenUniversity FromParse:^{
        [self.classPicker reloadAllComponents];
    }];
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
    return [self.dataStore.selectedUniversityClasses count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    BBClass *class = self.dataStore.selectedUniversityClasses[row];
    self.chosenClass = self.dataStore.selectedUniversityClasses[row];
    return class.title;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
        self.chosenClass = self.dataStore.selectedUniversityClasses[row];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBCreateMeetingNowViewController *nextVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"classSelected"]) {
        nextVC.chosenUniversity = self.chosenUniversity;
        nextVC.chosenClass = self.chosenClass;
    }
}


@end
