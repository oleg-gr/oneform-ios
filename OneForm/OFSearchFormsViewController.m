//
//  OFSearchFormsViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFSearchFormsViewController.h"

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
	
    //CAPTION
    self.caption = [[UILabel alloc] initWithFrame:CGRectMake(85.0, 20.0, 150.0, 21.0)];
    [self.caption setText:@"Search Forms"];
    [self.caption setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.caption];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
