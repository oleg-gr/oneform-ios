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
    
    self.scrollContainer = [[TPKeyboardAvoidingScrollView alloc]
                            initWithFrame: self.view.frame];
    self.scrollContainer.contentSize = CGSizeMake(320, 568);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollContainer];

    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self setNavigationBarHidden:YES];
    
    self.navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.scrollContainer addSubview:self.navBar];

    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    OFSearchBar *searchBar = [[OFSearchBar alloc] init];
    
    [self.scrollContainer addSubview:searchBar];

    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.scrollContainer addGestureRecognizer:tapOutOfText];
    
    NSLog(@"LOADED");
    
}

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
