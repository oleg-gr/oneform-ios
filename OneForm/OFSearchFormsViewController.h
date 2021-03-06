//
//  OFSearchFormsViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFNavigationBar.h"
#import "OFDoubleSearch.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface OFSearchFormsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITextField *activefield;
}
@property (nonatomic, strong) UILabel *caption;
@property (nonatomic, strong) OFNavigationBar *navBar;
@property (nonatomic, strong) OFDoubleSearch *searchBar;
@property (nonatomic, strong) UITableView *popularFormsTable;
@property (nonatomic, strong) NSMutableArray *popularForms;
@property (nonatomic, strong) NSMutableArray *popularFormsCheck;
@property (nonatomic, strong) UILabel *cellHeightCheck;
@property (nonatomic, strong) NSMutableDictionary *userData;


-(id) initWithUserData:(NSMutableDictionary*)userData;

@end
