//
//  OFFormViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFFormViewController.h"
#import "OFNavigationBar.h"
#import "OFTextField.h"

@interface OFFormViewController ()

@end

@implementation OFFormViewController

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
    
    //dummy
    
    formName = @"UAE Driver's License Form";
    isEditing = NO;
    status = nil;
    textFields = [[NSMutableArray alloc] init];
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd-yyyy"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:navBar];
    
    self.formTitle = [[OFFormTitle alloc] initWithYcoord:120 andTitle:formName];
    [self.view addSubview:self.formTitle];
    
    self.backButton = [[OFBackButton alloc] initWithFrame:CGRectMake(25, 80, 180, 40) andLabel:@"go back"];
    
    [self.view addSubview:self.backButton];
    
    UITapGestureRecognizer *goBack =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goBack)];
    [self.backButton addGestureRecognizer:goBack];
    
    self.forwardButton = [[OFForwardButton alloc] initWithFrame:CGRectMake(90, 210, 200, 40) andLabel:@"next empty field"];
    [self.forwardButton setHidden:YES];
    self.forwardButton.alpha = 0.0;
    
    [self.view addSubview:self.forwardButton];
    
    UITapGestureRecognizer *goNextEmpty =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goNextEmpty)];
    [self.forwardButton addGestureRecognizer:goNextEmpty];
    
    UITapGestureRecognizer *test =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(test)];
    [self.formTitle addGestureRecognizer:test];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    myData = @[
               [[NSMutableArray alloc] initWithArray: @[@"Name", @"Mariko Kuroda", @"text"]],
               [[NSMutableArray alloc] initWithArray: @[@"Birthdate", @"09-23-1993", @"date"]],
               [[NSMutableArray alloc] initWithArray: @[@"Gender", @"", @"radio", @[@"Male", @"Female"]]],
               [[NSMutableArray alloc] initWithArray: @[@"Occupation", @"", @"text"]],
               [[NSMutableArray alloc] initWithArray: @[@"Address", @"Sama Tower", @"text"]],
               [[NSMutableArray alloc] initWithArray: @[@"Nationality", @"Japan", @"radio", @[@"UAE", @"Japan", @"Russia", @"Australia", @"USA", @"France"]]],
               ];
    
    self.myDataTable = [[UITableView alloc] initWithFrame:CGRectMake(33.5f, 215, 320 - 33.5f, 270) style:UITableViewStylePlain];
    [self.myDataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.myDataTable setShowsVerticalScrollIndicator:NO];
    [self.myDataTable setDelegate:self];
    [self.myDataTable setDataSource:self];
    [self.view addSubview:self.myDataTable];
    
    self.horizontalScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 120, 240, 90)];
    [self.horizontalScroll setContentSize:CGSizeMake([myData count]*240 , 90)];
    [self.horizontalScroll setClipsToBounds:NO];
    [self.horizontalScroll setPagingEnabled : YES];
    [self.horizontalScroll setShowsHorizontalScrollIndicator:NO];
    self.horizontalScroll.delegate = self;
    
    for( int i = 0; i < [myData count]; i++)
    {
        OFTextField *textField = [[OFTextField alloc] initWithFrame:CGRectMake(240*i+20, 10, 200, 80) andLabel:myData[i][0]];
        [textField setTextFieldText:myData[i][1]];
        if ([myData[i][2] isEqualToString:@"date"])
        {
            if (![myData[i][1] isEqualToString:@""])
            {
                NSDate *date = [df dateFromString: myData[i][1]];
                [datePicker setDate:date];
            }
            [textField.textFieldInput setInputView:datePicker];
        }
        else if ([myData[i][2] isEqualToString:@"radio"])
        {
            UIPickerView *pickerView = [[UIPickerView alloc] init];
            pickerView.dataSource = self;
            pickerView.delegate = self;
            [textField.textFieldInput setInputView:pickerView];
        }
        textField.textFieldInput.delegate = self;
        [textFields addObject:textField];
        [self.horizontalScroll addSubview:textField];
    }
    [self.horizontalScroll setHidden:YES];
    [self.view addSubview:self.horizontalScroll];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    self.submitButton.frame = CGRectMake(47, 510, 225, 40);
    [self.submitButton setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [self.submitButton.titleLabel setFont: [UIFont fontWithName:@"Roboto-Thin" size:36]];
    //logic
    [self.submitButton addTarget:self
                          action:@selector(submitForm)
                forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:self.submitButton];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyPressed:) name: UITextFieldTextDidChangeNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyPressed:) name: UITextViewTextDidChangeNotification object: nil];
    
    [self updateProgressBar];
}

-(void)test
{
}

-(void)submitForm
{
    
}

-(void)datePickerValueChanged:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*) activefield.inputView;
    [activefield setText:[df stringFromDate: picker.date]];
    myData[current][1] = [df stringFromDate: picker.date];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [myData[current][3] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return myData[current][3][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [activefield setText:myData[current][3][row]];
    myData[current][1] = myData[current][3][row];
    [self updateProgressBar];
}

-(void)goNextEmpty
{
    int index = current;
    int length = (int) [myData count];
    for (int i = (current + 1) % length; ![myData[i][1] isEqualToString:@""]; i = (i+1) % length)
    {
        index = i;
    }
    initialScroll = YES;
    current = (index+1) % length;
    [self.horizontalScroll setContentOffset:CGPointMake(240*(current), 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (isEditing)
    {
        previous = current;
        current = self.horizontalScroll.contentOffset.x / self.horizontalScroll.frame.size.width;
        [[textFields objectAtIndex:current] becomeFR];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (initialScroll && isEditing)
    {
        [[textFields objectAtIndex:current] becomeFR];
        initialScroll = NO;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activefield = textField;
    if ([activefield.inputView isMemberOfClass:[UIPickerView class]])
    {
        int myRow = (int)[myData[current][3] indexOfObject:myData[current][1]];
        
        if (myRow > [myData[current][3] count])
        {
            myRow = 0;
        }
        
        [(UIPickerView*)activefield.inputView selectRow:myRow inComponent:0 animated:NO];
    }
    if (counter < 2 && [textField.text isEqualToString:@""])
    {
        [self.forwardButton setHidden:YES];
    }
    else if (counter == 1)
    {
        [self.forwardButton setHidden:NO];
    }
}


- (void)keyPressed:(NSNotification*)notification
{
    NSString *prevValue = myData[current][1];
    myData[current][1] = [[textFields objectAtIndex:current] getTextInput];
    NSString *curValue = myData[current][1];
    //to reduce number of checks
    if ((prevValue.length == 0 && curValue.length > 0))
    {
        [self updateProgressBar];
    }
    else if (prevValue.length > 0 && curValue.length == 0)
    {
        [self updateProgressBar];
        if (counter > 1)
        {
            [self.forwardButton setHidden:NO];
        }
    }
}

-(void)updateProgressBar //left here for counter calculations
{
    counter = 0;
    for (int i = 0; i < [myData count]; i++)
    {
        if ([myData[i][1] isEqualToString:@""])
        {
            counter++;
        }
    }
    if (counter == 0)
    {
        [self.forwardButton setHidden:YES];
    }
}

#pragma mark Table view related logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%li",(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    No cell reuse because of the custom contentview
//    if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UITapGestureRecognizer *startEditing = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                            action:@selector(goToField:)];
    [startEditing setCancelsTouchesInView:NO];
    [cell.contentView setUserInteractionEnabled:YES];
    [cell.contentView addGestureRecognizer:startEditing];
    NSArray *info = [myData objectAtIndex:indexPath.row];
    OFTextField *textfield = [[OFTextField alloc] initWithFrame:CGRectMake(0, 0, self.myDataTable.frame.size.width, 65) andLabel:info[0] andEditable:NO];
    [textfield setTextFieldText:info[1]];
    [cell.contentView addSubview:textfield];
//    }
    return cell;
}

-(void)goToField:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint tapLocation = [gestureRecognizer locationInView:self.myDataTable];
    NSIndexPath *tapIndexPath = [self.myDataTable indexPathForRowAtPoint:tapLocation];
    initialScroll = YES;
    [self.horizontalScroll setContentOffset:CGPointMake(240*tapIndexPath.row, 0) animated:YES];
    [self.forwardButton setHidden:NO];
    [self updateProgressBar];
    [UIView animateWithDuration:0.15 animations:^() {
        self.formTitle.alpha = 0.0;
        self.myDataTable.alpha = 0.0;
        self.horizontalScroll.alpha = 1.0;
        self.forwardButton.alpha = 1.0;
        [self.backButton.buttonLabel setText:@"save and go back"];
        [self.submitButton setFrame:CGRectMake(47, 284, 225, 40)];
    } completion:^(BOOL finished){
        if (finished)
        {
            [self.formTitle setHidden:YES];
            [self.myDataTable setHidden:YES];
            [self.horizontalScroll setHidden:NO];
        }
    }];
    isEditing = YES;
    if (current == tapIndexPath.row)
    {
        [[textFields objectAtIndex:current] becomeFR];
    }
    else
    {
        current = (int) tapIndexPath.row;
    }
}

- (void)goBack
{
    if (!isEditing)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.myDataTable reloadData];
        [self updateProgressBar];
        [UIView animateWithDuration:0.2 animations:^() {
            self.formTitle.alpha = 1.0;
            self.myDataTable.alpha = 1.0;
            self.horizontalScroll.alpha = 0.0;
            self.forwardButton.alpha = 0.0;
            [self.backButton.buttonLabel setText:@"go back"];
            [self.submitButton setFrame:CGRectMake(47, 510, 225, 40)];
        } completion:^(BOOL finished){
            if (finished)
            {
                [self.formTitle setHidden:NO];
                [self.myDataTable setHidden:NO];
                [self.horizontalScroll setHidden:YES];
                [self.forwardButton setHidden:YES];
            }
        }];
        [activefield resignFirstResponder];
        isEditing = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
