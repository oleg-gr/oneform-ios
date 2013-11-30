//
//  OFMyDataViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/30/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMyDataViewController.h"
#import "OFNavigationBar.h"
#import "OFFormTitle.h"

@interface OFMyDataViewController ()

@end

@implementation OFMyDataViewController

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
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:navBar];
    
    OFFormTitle *formTitle = [[OFFormTitle alloc] initWithYcoord:80 andTitle:@"My data"];
    
    [self.view addSubview:formTitle];
    
    self.qrCodeInteractionView = [[UIView alloc] initWithFrame:CGRectMake(267.5f, 80, 52, formTitle.frame.size.height)];
    [self.view addSubview:self.qrCodeInteractionView];
    UIImageView *qrCodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32.75f, 32.75f)];
    [qrCodeImage setCenter:CGPointMake(274.25f, 80 + formTitle.frame.size.height/2)];
    [qrCodeImage setImage:[UIImage imageNamed:@"qr_code.png"]];
    [self.view addSubview:qrCodeImage];
    
    
    
}

-(void) viewWillAppear:(BOOL)animated
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
