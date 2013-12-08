//
//  OFMyFormsViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFSearchBar.h"

@interface OFMyFormsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) OFSearchBar *searchBar;
@property (nonatomic, strong) UITableView *myFormsTable;
@property (nonatomic, strong) NSArray *myForms;

-(id) initWithUserData:(NSMutableArray*)userData;

@end
