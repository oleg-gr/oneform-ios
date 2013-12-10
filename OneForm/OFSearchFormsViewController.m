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
#import "OFFormProgress.h"
#import "OFFormViewController.h"
#import "OFHelperMethods.h"

@interface OFSearchFormsViewController ()

@end

@implementation OFSearchFormsViewController

-(id)initWithUserData:(NSMutableDictionary*)userData
{
    self = [super init];
    if (self) {
        self.userData = userData;
        [self updatePopularForms];
        
        NSLog(@"%@", userData);
        
    }
    return self;
}

-(void) updatePopularForms
{
    self.popularForms = [[NSMutableArray alloc] init];
    NSMutableDictionary *orgs_lookup = [self.userData objectForKey:@"orgs_lookup"];
    for (NSMutableDictionary *form in [self.userData objectForKey:@"forms"])
    {
        NSArray *orgs = [form objectForKey:@"orgs" ];
        NSString *orgs_string = [orgs_lookup objectForKey:[orgs objectAtIndex:0]];
        for (int i = 1; i < [orgs count]; i++)
        {
            orgs_string = [orgs_string stringByAppendingString:[NSString stringWithFormat:@", %@", [orgs_lookup objectForKey:[orgs objectAtIndex:i]]]];
        }
        [self.popularForms addObject:
         @[[form objectForKey:@"name"], orgs_string, [form objectForKey:@"_id"]]];
    }
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
    
    self.popularFormsTable = [[UITableView alloc] initWithFrame:CGRectMake(34.75f, 252.5f, 237.75f, 275) style:UITableViewStylePlain];
    [self.popularFormsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.popularFormsTable setShowsVerticalScrollIndicator:NO];
    [self.popularFormsTable setDelegate:self];
    [self.popularFormsTable setDataSource:self];
    
    [self.view addSubview:self.popularFormsTable];
    
    
    self.cellHeightCheck = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 52)];
    [self.cellHeightCheck setNumberOfLines:2];
    [self.cellHeightCheck setFont:[UIFont fontWithName:@"Roboto-Regular" size:21]];
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
    NSArray *info = [self.popularForms objectAtIndex:indexPath.row];
    [self.cellHeightCheck setText:info[0]];
    [self.cellHeightCheck sizeToFit];
    if ((int)(self.cellHeightCheck.frame.size.height/self.cellHeightCheck.font.leading) == 1)
    {
        return 85;
    }
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%li",(long)indexPath.row];
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
        organizationName = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, 200, 38)];
        [organizationName setTextColor:UI_COLOR];
        [organizationName setNumberOfLines:2];
        [organizationName setFont:[UIFont fontWithName:@"Roboto-Light" size:16]];
        NSArray *info = [self.popularForms objectAtIndex:indexPath.row];
        [cellLabel setText:info[0]];
        [cellLabel sizeToFit];
        [organizationName setText:info[1]];
        if ((int)(cellLabel.frame.size.height/cellLabel.font.leading) == 1)
        {
            [organizationName setFrame:CGRectMake(0, 40, 200, 20 * (int)(organizationName.frame.size.height/organizationName.font.leading))];
            [cellLabel setFrame:CGRectMake(0, 0, 207.25, 52)];
        }
        [cell.contentView addSubview:organizationName];
        [cell.contentView addSubview:cellLabel];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *formId = [[self.userData objectForKey:@"forms_lookup"] objectForKey:[NSNumber numberWithInt:indexPath.row]];
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:formId delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
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
