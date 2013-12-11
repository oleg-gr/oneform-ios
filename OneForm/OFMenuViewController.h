//
//  OFMenuViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFSearchFormsViewController.h"
#import "OFMyFormsViewController.h"
#import "OFMyDataViewController.h"
#import "OFLoginViewController.h"
#import "OFSettingsViewController.h"

@interface OFMenuViewController : UIViewController

@property (nonatomic, strong) UIButton *searchFormsLabel;
@property (nonatomic, strong) UIButton *myFormsLabel;
@property (nonatomic, strong) UIButton *myDataLabel;
@property (nonatomic, strong) UIButton *settingsLabel;
@property (nonatomic, strong) UIButton *logOutLabel;
@property (nonatomic, strong) NSMutableDictionary *userData;

-(id) initWithUserData:(NSMutableDictionary*)userData;

@end
