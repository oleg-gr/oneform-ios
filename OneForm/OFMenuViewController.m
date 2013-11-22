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
    self.myFormsLabel = [self getMenuItemWithYcoord:132.0 andLabel:@"My forms"];
    [self.view addSubview:self.myFormsLabel];
    self.myDataLabel = [self getMenuItemWithYcoord:186.0 andLabel:@"My data"];
    [self.view addSubview:self.myDataLabel];
    self.settingsLabel = [self getMenuItemWithYcoord:486.5 andLabel:@"Settings"];
    [self.view addSubview:self.settingsLabel];
    self.logOutLabel = [self getMenuItemWithYcoord:523.5 andLabel:@"Log out"];
    [self.view addSubview:self.logOutLabel];
}

- (UILabel*)getMenuItemWithYcoord:(float)coord andLabel:(NSString*)text
{
    UILabel *label = [[ UILabel alloc]
                             initWithFrame:CGRectMake(LEFT_ALIGN_LINE, coord, 100, 40)];
    label.textColor = UI_COLOR;
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:18];
    label.text = text;
    [label sizeToFit];
    return label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
