//
//  OFSearchFormsViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFSearchFormsViewController.h"
#import "SWRevealViewController.h"
#import "OFSearchBar.h"
#import "OFQRCoderViewController.h"
#import "OFFormProgress.h"
#import "OFFormViewController.h"

@interface OFSearchFormsViewController ()

@end

@implementation OFSearchFormsViewController

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
    
    self.navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:self.navBar];
    
    self.searchBar = [[OFDoubleSearch alloc] initWithTopPlaceholder:@"form name" andBottom:@"agency name"];
    
    [self.view addSubview:self.searchBar];

    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
    //DUMMY
    
    self.popularForms = @[@[@"UAE driver's license form", @"Abu Dhabi Customs Administration"], @[@"Naturalization form", @"Abu Dhabi Chamber of Commerce and Industry"], @[@"Birth certificate" , @"Abu Dhabi Education Council Council Council Council"], @[@"Change of address", @"Abu Dhabi home authority"], @[@"Visa application form", @"UAE Customs"], @[@"Visa renewal form", @"Immigration"]];
    
    self.popularFormsTable = [[UITableView alloc] initWithFrame:CGRectMake(34.75f, 252.5f, 237.75f, 280) style:UITableViewStylePlain];
    [self.popularFormsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.popularFormsTable setShowsVerticalScrollIndicator:NO];
    [self.popularFormsTable setDelegate:self];
    [self.popularFormsTable setDataSource:self];
    
    [self.view addSubview:self.popularFormsTable];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}


#pragma mark Table view related logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.popularForms count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%i",indexPath.row];
    UILabel *cellLabel;
    UILabel *organizationName;
    UIImageView *arrow;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 207.25, 52)];
        [cellLabel setTextColor:UI_COLOR];
        [cellLabel setNumberOfLines:2];
        [cellLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:21]];
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.popularFormsTable.frame.size.width - 20.25f, 0, 20.25f, 33.75f)];
        arrow.center = CGPointMake(arrow.center.x, 26);
        [arrow setImage:[UIImage imageNamed:@"form_choice_arrow.png"]];
        [cell.contentView addSubview:arrow];
        organizationName = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, 207.25, 38)];
        [organizationName setTextColor:UI_COLOR];
        [organizationName setNumberOfLines:2];
        [organizationName setFont:[UIFont fontWithName:@"Roboto-Light" size:16]];
        
        UITapGestureRecognizer *goToForm = [[UITapGestureRecognizer alloc]
                                                       initWithTarget:self
                                                       action:@selector(goToForm)];
        [goToForm setCancelsTouchesInView:NO];
        [cell.contentView setUserInteractionEnabled:YES];
        [cell.contentView  addGestureRecognizer:goToForm];
    
        NSArray *info = [self.popularForms objectAtIndex:indexPath.row];
        [cellLabel setText:info[0]];
        [cellLabel sizeToFit];
        [organizationName setText:info[1]];
        if ((int)(cellLabel.frame.size.height/cellLabel.font.leading) == 1)
        {
            [organizationName setFrame:CGRectMake(0, 40, 207.25, 20 * (int)(organizationName.frame.size.height/organizationName.font.leading))];
            [cellLabel setFrame:CGRectMake(0, 0, 207.25, 52)];
        }
        [cell.contentView addSubview:organizationName];
        [cell.contentView addSubview:cellLabel];
    }
    
    return cell;
    
}

-(void)goToForm
{
    OFFormViewController *form = [[OFFormViewController alloc] init];
    [self.navigationController pushViewController:form animated:YES];
}

#pragma mark Keyboard dismiss

-(void)dismissKeyboard
{
    [self.searchBar.searchQuery resignFirstResponder];
    [self.searchBar.secondSearchQuery resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
