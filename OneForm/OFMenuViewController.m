//
//  OFMenuViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMenuViewController.h"
#define LEFT_ALIGN_LINE 32


@interface OFMenuViewController ()

@end

@implementation OFMenuViewController

- (id)initWithUserData:(NSMutableDictionary*)userData
{
    self = [super init];
    if (self) {
        self.userData = userData;
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
    
//    self.settingsLabel = [self getMenuItemWithYcoord:486.5 andLabel:@"Settings"];
//    [self.view addSubview:self.settingsLabel];
//    UITapGestureRecognizer *goToSettings =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(goToSettings)];
//    [self.settingsLabel addGestureRecognizer:goToSettings];
    
    self.logOutLabel = [self getMenuItemWithYcoord:523.5 andLabel:@"Log out"];
    [self.view addSubview:self.logOutLabel];
    
    UITapGestureRecognizer *logout =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(logout)];
    [self.logOutLabel addGestureRecognizer:logout];
}

- (void) goToSearch
{
    OFSearchFormsViewController *searchController= [[OFSearchFormsViewController alloc] initWithUserData:self.userData];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:searchController];
    [frontViewController setNavigationBarHidden:YES];
    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
}

- (void) goToMyForms
{
    OFMyFormsViewController *myForms= [[OFMyFormsViewController alloc] initWithUserData:self.userData];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:myForms];
    [frontViewController setNavigationBarHidden:YES];
    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
}

- (void) goToMyData
{
    OFMyDataViewController *myData= [[OFMyDataViewController alloc] initWithUserData:self.userData];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:myData];
    [frontViewController setNavigationBarHidden:YES];
    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
}

//- (void) goToSettings
//{
//    self.settings= [[OFSettingsViewController alloc] initWithUserData:userData];
//    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:self.settings];
//    [frontViewController setNavigationBarHidden:YES];
//    [[self revealViewController] setFrontViewController:frontViewController animated:YES];
//}

- (void) logout
{
    //log out logic
    [self dismissViewControllerAnimated:YES completion:nil];
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
