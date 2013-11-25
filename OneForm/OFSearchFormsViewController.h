//
//  OFSearchFormsViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFNavigationBar.h"
#import "OFSearchBar.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface OFSearchFormsViewController : UINavigationController

@property (nonatomic, strong) UILabel *caption;
@property (nonatomic, strong) OFNavigationBar *navBar;
@property (nonatomic, strong) OFSearchBar *searchBar;


@end
