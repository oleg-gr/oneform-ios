//
//  OFMyCardViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMyCardViewController.h"
#import "OFNavigationBar.h"
#import "OFBackButton.h"

@interface OFMyCardViewController ()

@end

@implementation OFMyCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    UILabel *title = [[ UILabel alloc] initWithFrame:CGRectMake(40, 135, 320, 40)];
    [title setTextColor:UI_COLOR];
    [title setNumberOfLines:0];
    [title setFont:[UIFont fontWithName:@"Roboto-Regular" size:26]];
    [title setText:@"My ID card"];
    [title sizeToFit];
    [self.view addSubview:title];
    
    UIImageView *myQRimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_data_qr.png"]];
    [myQRimage setFrame:CGRectMake(69, 198, 182, 182)];
    [self.view addSubview:myQRimage];
    
    UILabel *scanLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 430, 240, 80)];
    [scanLabel setNumberOfLines:2];
    [scanLabel setTextAlignment:NSTextAlignmentCenter];
    //    [tapPlus sizeToFit];
    [scanLabel setText:@"Scan the QR code to share your data"];
    [scanLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:27]];
    [scanLabel setTextColor:UI_COLOR];
    [self.view addSubview:scanLabel];
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
