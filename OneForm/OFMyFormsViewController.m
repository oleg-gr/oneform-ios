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
        self.userData = userData;
        [self updateMyForms];
    }
    return self;
}

-(void) updateMyForms
{
    self.myForms = [[NSMutableArray alloc] init];
    NSMutableArray *forms = [[self.userData objectForKey:@"user"] objectForKey:@"forms"];
    NSMutableDictionary *orgs_lookup = [self.userData objectForKey:@"orgs_lookup"];
    
    for (NSMutableDictionary *form in forms)
    {
        NSString *form_id = [form objectForKey:@"_id"];
        NSMutableDictionary *form_def = [[self.userData objectForKey:@"forms"] objectAtIndex:[[[self.userData objectForKey:@"forms_reverse_lookup"] objectForKey:form_id] integerValue]];
        NSString *name = [form_def objectForKey:@"name"];
        NSString *status = [form objectForKey:@"status"];
        NSNumber *progress;
        if ([status isEqualToString:@"submitted"])
        {
            progress = [NSNumber numberWithFloat:1.0f];
        }
        else
        {
            progress = [NSNumber numberWithFloat:0.0f];
        }
        
        NSArray *orgs = [form_def objectForKey:@"orgs" ];
        NSString *orgs_string = [orgs_lookup objectForKey:[orgs objectAtIndex:0]];
        for (int i = 1; i < [orgs count]; i++)
        {
            orgs_string = [orgs_string stringByAppendingString:[NSString stringWithFormat:@", %@", [orgs_lookup objectForKey:[orgs objectAtIndex:i]]]];
        }
        NSArray *entry = @[name, progress, status, orgs_string, form_id];
        [self.myForms addObject:entry];
    }
    NSLog(@"%@", self.myForms);
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
    [self updateMyForms];
    [self.myFormsTable reloadData];
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
