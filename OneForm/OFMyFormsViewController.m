//
//  OFMyFormsViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMyFormsViewController.h"
#import "OFNavigationBar.h"
#import "OFFormProgress.h"

@interface OFMyFormsViewController ()

@end

@implementation OFMyFormsViewController

-(id) initWithUserData:(NSMutableDictionary*)userData;
{
    self = [super init];
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
    
    self.searchBar = [[OFSearchBar alloc] initWithBottomLabel:@"My forms" withQR:NO];
    
    [self.view addSubview:self.searchBar];
    
    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
    //DUMMY
    
    self.myForms = @[
                     @[@"UAE driver's license", @0.9f, @"2 more", @"Abu Dhabi Customs Administration"],
                     @[@"Birth certificate", @1.0f, @"Reviewed", @"Abu Dhabi Chamber of Commerce and Industry"],
                     @[@"Change of address", @1.0f, @"Ready to submit", @"Abu Dhabi Education Council"],
                     @[@"Visa application form", @0.0f, @"New data requested", @"Abu Dhabi home authority"],
                     @[@"Visa renewal form", @1.0f, @"Government processing in action", @"UAE Customs"],
                     @[@"Naturalization form", @0.5f, @"5 more", @"Immigration"],
                     @[@"Emirates ID application", @0.7f, @"1 more", @"Abu Dhabi Chamber of Commerce and Industry"]];
    
    self.myFormsTable = [[UITableView alloc] initWithFrame:CGRectMake(34.75f, 234.5f, 246.75f, 314) style:UITableViewStylePlain];
    [self.myFormsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.myFormsTable setShowsVerticalScrollIndicator:NO];
    [self.myFormsTable setDelegate:self];
    [self.myFormsTable setDataSource:self];
    
    [self.view addSubview:self.myFormsTable];

}

#pragma mark Table view related logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myForms count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%li",(long)indexPath.row];
    OFFormProgress *progress;
    UILabel *cellLabel;
    UILabel *organizationName;
    UIImageView *arrow;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 208, 25)];
        [cellLabel setTextColor:UI_COLOR];
        [cellLabel setNumberOfLines:1];
        [cellLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:21]];
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.myFormsTable.frame.size.width - 20.25f, 5, 20.25f, 33.75f)];
        arrow.center = CGPointMake(arrow.center.x, 26);
        [cell.contentView addSubview:arrow];
        [arrow setImage:[UIImage imageNamed:@"form_choice_arrow.png"]];
        progress = [[OFFormProgress alloc] initWithFrame:CGRectMake(0, 66, 160, 25) andProgress:0 andText:nil andTextSize:14 andTextAlignment:NSTextAlignmentLeft];
        organizationName = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 200, 38)];
        [organizationName setTextColor:UI_COLOR];
        [organizationName setNumberOfLines:2];
        [organizationName setFont:[UIFont fontWithName:@"Roboto-Light" size:16]];
        NSArray *info = [self.myForms objectAtIndex:indexPath.row];
        [cellLabel setText:info[0]];
        [progress setProgress:[info[1] floatValue]];
        [progress setText:info[2]];
        [organizationName setText:info[3]];
        [cell.contentView addSubview:organizationName];
        [cell.contentView addSubview:cellLabel];
        [cell.contentView addSubview:progress];
    }

    return cell;
}

-(void) viewWillAppear:(BOOL)animated
{
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

#pragma mark Keyboard dismiss

-(void)dismissKeyboard
{
    [self.searchBar.searchQuery resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
