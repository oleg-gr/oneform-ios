//
//  OFMenuViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMenuViewController.h"
#define LEFT_ALIGN_LINE 32
#import "OFSearchFormsViewController.h"
#import "OFMyFormsViewController.h"
#import "OFMyDataViewController.h"

@interface OFMenuViewController ()

@end

@implementation OFMenuViewController

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
    self.searchFormsLabel = [self getMenuItemWithYcoord:78.5 andLabel:@"Search Forms"];
    [self.view addSubview:self.searchFormsLabel];
    UITapGestureRecognizer *goToSearch =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToSearch)];
    [self.searchFormsLabel addGestureRecognizer:goToSearch];
    
    self.myFormsLabel = [self getMenuItemWithYcoord:132.0 andLabel:@"My forms"];
    [self.view addSubview:self.myFormsLabel];
    UITapGestureRecognizer *goToMyForms =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToMyForms)];
    [self.myFormsLabel addGestureRecognizer:goToMyForms];
    
    self.myDataLabel = [self getMenuItemWithYcoord:186.0 andLabel:@"My data"];
    [self.view addSubview:self.myDataLabel];
    UITapGestureRecognizer *goToMyData =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToMyData)];
    [self.myDataLabel addGestureRecognizer:goToMyData];
    
    self.settingsLabel = [self getMenuItemWithYcoord:486.5 andLabel:@"Settings"];
    [self.view addSubview:self.settingsLabel];
    self.logOutLabel = [self getMenuItemWithYcoord:523.5 andLabel:@"Log out"];
    [self.view addSubview:self.logOutLabel];
}

- (void) goToSearch
{
    OFSearchFormsViewController *searchController= [[OFSearchFormsViewController alloc] init];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:searchController];
    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
}

- (void) goToMyForms
{
    OFMyFormsViewController *myForms= [[OFMyFormsViewController alloc] init];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:myForms];
    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
}

- (void) goToMyData
{
    OFMyDataViewController *myData= [[OFMyDataViewController alloc] init];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:myData];
    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
}

- (UIButton*)getMenuItemWithYcoord:(float)coord andLabel:(NSString*)text
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(LEFT_ALIGN_LINE, coord, 100, 40)];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:18]];
    [button sizeToFit];
    return button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
