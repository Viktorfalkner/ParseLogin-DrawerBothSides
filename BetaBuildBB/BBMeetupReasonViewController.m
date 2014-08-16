//
//  BBMeetupReasonViewController.m
//  BetaBuildBB
//
//  Created by Troy Barrett on 8/16/14.
//
//

#import "BBMeetupReasonViewController.h"
#import "BBCreateMeetingNowViewController.h"

@interface BBMeetupReasonViewController ()

@property (strong, nonatomic) IBOutlet UIPickerView *meetupPicker;

@property (strong, nonatomic) NSArray *meetupReasons;

@end

@implementation BBMeetupReasonViewController

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
    self.meetupReasons = @[@"Homework", @"Mid-Term", @"Final", @"Review"];
    self.meetupPicker.dataSource = self;
    self.meetupPicker.delegate = self;

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
    return [self.meetupReasons count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.meetupReasons[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    retval.text = self.meetupReasons[row];
    self.chosenActivity = self.meetupReasons[row];
    retval.adjustsFontSizeToFitWidth = YES;
    return retval;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.chosenActivity = self.meetupReasons[row];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBCreateMeetingNowViewController *nextVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"activitySelected"]) {
        nextVC.chosenUniversity = self.chosenUniversity;
        nextVC.chosenClass = self.chosenClass;
        nextVC.chosenActivity = self.chosenActivity;
    }
}


@end
