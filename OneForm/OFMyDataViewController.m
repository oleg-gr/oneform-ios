//
//  OFMyDataViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/30/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMyDataViewController.h"
#import "OFNavigationBar.h"
#import "OFFormTitle.h"
#import "OFTextField.h"

@interface OFMyDataViewController ()

@end

@implementation OFMyDataViewController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:navBar];
    
    OFFormTitle *formTitle = [[OFFormTitle alloc] initWithYcoord:80 andTitle:@"My data"];
    
    [self.view addSubview:formTitle];
    
    self.qrCodeInteractionView = [[UIView alloc] initWithFrame:CGRectMake(267.5f, 80, 52, formTitle.frame.size.height)];
    [self.view addSubview:self.qrCodeInteractionView];
    UIImageView *qrCodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32.75f, 32.75f)];
    [qrCodeImage setCenter:CGPointMake(274.25f, 80 + formTitle.frame.size.height/2)];
    [qrCodeImage setImage:[UIImage imageNamed:@"qr_code.png"]];
    [self.view addSubview:qrCodeImage];
    
    myData = @[
                     @[@"Name", @"Mariko Kuroda", @15],
                     @[@"Birthdate", @"09-23-1993", @15],
                     @[@"Gender", @"Female", @20],
                     @[@"Occupation", @"Student", @7],
                     @[@"Address", @"Sama Tower", @1],
                     @[@"Nationality", @"Japan", @2],
                     ];
    
    self.myDataTable = [[UITableView alloc] initWithFrame:CGRectMake(33.5f, 165, 320 - 33.5f, 342) style:UITableViewStylePlain];
    [self.myDataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.myDataTable setShowsVerticalScrollIndicator:NO];
    [self.myDataTable setDelegate:self];
    [self.myDataTable setDataSource:self];
    
    [self.view addSubview:self.myDataTable];
    
}


#pragma mark Table view related logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%i",indexPath.row];
    UILabel *bottomLabel;
    OFTextField *textfield;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, self.myDataTable.frame.size.width - 10, 24)];
        [bottomLabel setTextColor:UI_COLOR];
        [bottomLabel setNumberOfLines:1];
        [bottomLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:19]];
        [bottomLabel setTextAlignment:NSTextAlignmentRight];
        NSArray *info = [myData objectAtIndex:indexPath.row];
        textfield = [[OFTextField alloc] initWithFrame:CGRectMake(0, 0, self.myDataTable.frame.size.width, 65) andLabel:info[0] andEditable:NO];
        [textfield setTextFieldText:info[1]];
        [bottomLabel setText:[NSString stringWithFormat:@"%@ have access", info[2]]];
        [cell.contentView addSubview:textfield];
        [cell.contentView addSubview:bottomLabel];
    }
    return cell;
}

-(void) viewWillAppear:(BOOL)animated
{
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
