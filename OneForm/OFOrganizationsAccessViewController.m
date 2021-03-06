//
//  OFOrganizationsAccessViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFOrganizationsAccessViewController.h"
#import "OFNavigationBar.h"
#import "OFBackButton.h"
#import "OFFormTitle.h"
#import "OFTextField.h"

@interface OFOrganizationsAccessViewController ()

@end

@implementation OFOrganizationsAccessViewController

-(id) initWithOrgs:(NSMutableArray*)orgs andUserData:(NSMutableDictionary*)userData
{
    self = [super init];
    if (self) {
        self.organizations = [[NSMutableArray alloc] init];
        for (NSString *org in orgs)
        {
            [self.organizations addObject:[[userData objectForKey:@"orgs_lookup"] objectForKey:org]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:navBar];
    
    OFBackButton *backButton = [[OFBackButton alloc] initWithFrame:CGRectMake(25, 85.5f, 110, 40) andLabel:@"go back"];
    
    [self.view addSubview:backButton];
    
    UITapGestureRecognizer *goBack =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goBack)];
    [backButton addGestureRecognizer:goBack];
    
    OFFormTitle *title = [[OFFormTitle alloc] initWithYcoord:130 andTitle:@"Organizations with access"];
    [self.view addSubview:title];
    
    
    self.organizationsTable = [[UITableView alloc] initWithFrame:CGRectMake(33.5f, 220, 320 - 33.5f, 330) style:UITableViewStylePlain];
    [self.organizationsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.organizationsTable setShowsVerticalScrollIndicator:NO];
    [self.organizationsTable setDelegate:self];
    [self.organizationsTable setDataSource:self];
    
    [self.view addSubview:self.organizationsTable];
    
}

#pragma mark Table view related logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.organizations count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%li",(long)indexPath.row];
    UILabel *text;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        float width = self.organizationsTable.frame.size.width;
        
        text = [[ UILabel alloc]
                           initWithFrame:CGRectMake(0, 0, width-15, 78)];
        [text setTextColor:UI_COLOR];
        [text setNumberOfLines:2];
        [text setFont:[UIFont fontWithName:@"Roboto-Light" size:22]];
        [text setText:[self.organizations objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:text];
        
        UIView *lineView = [[UIView alloc]
                            initWithFrame:CGRectMake(0, 78, width, 1)];
        lineView.backgroundColor = UI_COLOR;
        [cell.contentView addSubview:lineView];
    }
    return cell;
}


- (void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
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
