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

@interface OFOrganizationsAccessViewController ()

@end

@implementation OFOrganizationsAccessViewController

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
