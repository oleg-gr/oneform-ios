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
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self setNavigationBarHidden:YES];
    
    self.navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:self.navBar];

    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    self.searchBar = [[OFSearchBar alloc] initWithBottomLabel:@"Popular forms"];
    
    [self.view addSubview:self.searchBar];

    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
    NSLog(@"LOADED");
    
    
    //DUMMY
    
    self.popularForms = @[@"UAE driver's license form", @"Naturalization form", @"Birth certificate", @"Change of address", @"Visa application form", @"Visa renewal form"];
    
    self.popularFormsTable = [[UITableView alloc] initWithFrame:CGRectMake(34.75f, 262.5f, 237.75f, 260) style:UITableViewStylePlain];
    [self.popularFormsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.popularFormsTable setShowsVerticalScrollIndicator:NO];
    [self.popularFormsTable setDelegate:self];
    [self.popularFormsTable setDataSource:self];
    
    [self.view addSubview:self.popularFormsTable];
    
}

#pragma Table view related logic
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.popularForms count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"Cell";
    
    UILabel *cellLabel;
    UIImageView *arrow;
    float height = 52.5;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 207.25, height)];
        [cellLabel setTextColor:UI_COLOR];
        [cellLabel setNumberOfLines:2];
        [cellLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:21]];
        [cell.contentView addSubview:cellLabel];
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.popularFormsTable.frame.size.width - 20.25f, 0, 20.25f, 33.75f)];
        arrow.center = CGPointMake(arrow.center.x, height/2);
        [arrow setImage:[UIImage imageNamed:@"form_choice_arrow.png"]];
        [cell.contentView addSubview:arrow];
    }
    
    [cellLabel setText:[self.popularForms objectAtIndex:indexPath.row]];
    
    return cell;
    
}

#pragma Keyboard dismiss

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
