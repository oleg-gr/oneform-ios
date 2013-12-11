//
//  OFMyFormsViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFSearchBar.h"
#import "OFFormViewController.h"

@interface OFMyFormsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITextField *activefield;
}

@property (nonatomic, strong) OFSearchBar *searchBar;
@property (nonatomic, strong) UITableView *myFormsTable;
@property (nonatomic, strong) NSMutableArray *myForms;
@property (nonatomic, strong) NSMutableDictionary *userData;
@property (nonatomic, strong) NSMutableArray *myFormsCheck;

-(id) initWithUserData:(NSMutableDictionary*)userData;

@end
