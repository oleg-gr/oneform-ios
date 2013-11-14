//
//  OFMenuViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFMenuViewController.h"

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
	// Do any additional setup after loading the view.
    self.caption = [[UILabel alloc] initWithFrame:CGRectMake(85.0, 20.0, 150.0, 21.0)];
    [self.caption setText:@"Menu"];
    [self.caption setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.caption];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
