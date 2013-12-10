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
#import "OFOrganizationsAccessViewController.h"

@interface OFMyDataViewController ()

@end

@implementation OFMyDataViewController

-(id) initWithUserData:(NSMutableDictionary*)userData;
{
    self = [super init];
    if (self) {
        self.userData = userData;
        [self updateMyData];
    }
    return self;
}

- (void)updateMyData
{
    self.myData = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *data = [[self.userData objectForKey:@"user"] objectForKey:@"data"];
    
    for (NSString *data_id in data)
    {
        NSMutableDictionary *field = [data objectForKey:data_id];
        NSString *name = [[[self.userData objectForKey:@"fields"] objectAtIndex:[[[self.userData objectForKey:@"fields_reverse_lookup"] objectForKey:data_id] integerValue]] objectForKey:@"name"];
        
        [self.myData addObject: @[name, [field objectForKey:@"value"], [NSNumber numberWithInteger:[[field objectForKey:@"access"] count]], data_id]];
    }
    
//    myData = @[
//               @[@"Name", @"Mariko Kuroda", @15],
//               @[@"Birthdate", @"09-23-1993", @15],
//               @[@"Gender", @"Female", @20],
//               @[@"Occupation", @"Student", @7],
//               @[@"Address", @"Sama Tower", @1],
//               @[@"Nationality", @"Japan", @2],
//               ];

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
    
    
    self.myDataTable = [[UITableView alloc] initWithFrame:CGRectMake(33.5f, 165, 320 - 33.5f, 342) style:UITableViewStylePlain];
    [self.myDataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.myDataTable setShowsVerticalScrollIndicator:NO];
    [self.myDataTable setDelegate:self];
    [self.myDataTable setDataSource:self];
    
    [self.view addSubview:self.myDataTable];
    
}


#pragma mark Table view related logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%li",(long)indexPath.row];
    UILabel *bottomLabel;
    OFTextField *textfield;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        float width = self.myDataTable.frame.size.width;
        bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - 10, 55, width/2 - 10, 24)];
        [bottomLabel setTextColor:UI_COLOR];
        [bottomLabel setNumberOfLines:1];
        [bottomLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:19]];
        [bottomLabel setTextAlignment:NSTextAlignmentRight];
        
        UITapGestureRecognizer *organizationsAccess = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                       action:@selector(goToOrganizationsWithAccess:)];
        [organizationsAccess setCancelsTouchesInView:NO];
        [bottomLabel setUserInteractionEnabled:YES];
        [bottomLabel addGestureRecognizer:organizationsAccess];
        
        NSArray *info = [self.myData objectAtIndex:indexPath.row];
        textfield = [[OFTextField alloc] initWithFrame:CGRectMake(0, 0, width, 65) andLabel:info[0] andEditable:NO];
        [textfield setTextFieldText:info[1]];
        [bottomLabel setText:[NSString stringWithFormat:@"%@ have access", info[2]]];
        [cell.contentView addSubview:textfield];
        [cell.contentView addSubview:bottomLabel];
    }
    return cell;
}

-(void) goToOrganizationsWithAccess:(UILabel*)label
{
    //grab tag assigned to ID and display respective details
    OFOrganizationsAccessViewController *organizations = [[OFOrganizationsAccessViewController alloc] init];
    [self.navigationController pushViewController:organizations animated:YES];
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
