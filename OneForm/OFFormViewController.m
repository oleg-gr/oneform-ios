//
//  OFFormViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFFormViewController.h"
#import "OFNavigationBar.h"
#import "OFFormTitle.h"
#import "OFBackButton.h"
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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:navBar];
    
    OFFormTitle *formTitle = [[OFFormTitle alloc] initWithYcoord:120 andTitle:formName];
    [self.view addSubview:formTitle];
    
    OFBackButton *backButton = [[OFBackButton alloc] initWithFrame:CGRectMake(25, 80, 110, 40) andLabel:@"go back"];
    
    [self.view addSubview:backButton];
    
    UITapGestureRecognizer *goBack =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goBack)];
    [backButton addGestureRecognizer:goBack];
    
    myData = [[NSMutableArray alloc]
              initWithArray:@[
               @[@"Name", @"Mariko Kuroda", @"text"],
               @[@"Birthdate", @"09-23-1993", @"date"],
               @[@"Gender", @"", @"radio", @[@"Male", @"Female"]],
               @[@"Occupation", @"", @"text"],
               @[@"Address", @"Sama Tower", @"text"],
               @[@"Nationality", @"Japan", @"radio", @[@"UAE", @"Japan", @"Russia", @"Australia", @"USA", @"France"]],
               ]];
    
    self.myDataTable = [[UITableView alloc] initWithFrame:CGRectMake(33.5f, 215, 320 - 33.5f, 270) style:UITableViewStylePlain];
    [self.myDataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.myDataTable setShowsVerticalScrollIndicator:NO];
    [self.myDataTable setDelegate:self];
    [self.myDataTable setDataSource:self];
    [self.view addSubview:self.myDataTable];
    
    self.progressBar = [[OFFormProgress alloc] initWithFrame:CGRectMake(47, 510, 225, 40) andProgress:0 andText:@"" andTextSize:26 andTextAlignment:NSTextAlignmentCenter];
    [self updateProgressBar];
    [self.view addSubview:self.progressBar];
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
    OFTextField *textfield;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        float width = self.myDataTable.frame.size.width;
        
        textfield = [[OFTextField alloc] initWithFrame:CGRectMake(0, 0, width, 65) andLabel:@"" andEditable:NO];

        [cell.contentView addSubview:textfield];
        UITapGestureRecognizer *startEditing = [[UITapGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(goToField)];
        [startEditing setCancelsTouchesInView:NO];
        [cell.contentView setUserInteractionEnabled:YES];
        [cell.contentView addGestureRecognizer:startEditing];
    }
    
    NSArray *info = [myData objectAtIndex:indexPath.row];
    [textfield setLabelText:info[0]];
    [textfield setTextFieldText:info[1]];
    
    return cell;
}

-(void)goToField
{
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
