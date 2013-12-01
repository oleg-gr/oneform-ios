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
    
    UITapGestureRecognizer *test =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(test)];
    [self.formTitle addGestureRecognizer:test];
    
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
    
    for( int i = 0; i < [myData count]; i++)
    {
        OFTextField *textField = [[OFTextField alloc] initWithFrame:CGRectMake(240*i + 20, 10, 200, 80) andLabel:myData[i][0]];
        [textField setTextFieldText:myData[i][1]];
        [textFields addObject:textField];
        [self.horizontalScroll addSubview:textField];
    }
    [self.horizontalScroll setHidden:YES];
    [self.view addSubview:self.horizontalScroll];
    
    self.progressBar = [[OFFormProgress alloc] initWithFrame:CGRectMake(47, 510, 225, 40) andProgress:0 andText:@"" andTextSize:26 andTextAlignment:NSTextAlignmentCenter];
    [self updateProgressBar];
    [self.view addSubview:self.progressBar];
}

-(void)test
{
}

-(void)updateProgressBar
{
    if (status == nil)
    {
        int counter = 0;
        for (int i = 0; i < [myData count]; i++)
        {
            if ([myData[i][1] isEqualToString:@""])
            {
                counter++;
            }
        }
        float num = counter;
        float den = [myData count];
        [self.progressBar setProgress:1 - num/den];
        [self.progressBar setText:[NSString stringWithFormat:@"%d more", counter]];
    }
    else
    {
        [self.progressBar setProgress:1];
        [self.progressBar setText:status];
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
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%i",indexPath.row];
    
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
    [self.myDataTable setHidden:YES];
    [self.horizontalScroll setHidden:NO];
    [self.horizontalScroll scrollRectToVisible:CGRectMake(240*tapIndexPath.row, 0, 240, 90) animated:YES];
    [self.formTitle setHidden:YES];
    [self.backButton.buttonLabel setText:@"save and go back"];
    [textFields[tapIndexPath.row] becomeFR];
    
}

- (void)goBack
{
    if (!isEditing)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
