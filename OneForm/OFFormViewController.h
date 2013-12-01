//
//  OFFormViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFFormProgress.h"
#import "OFFormTitle.h"
#import "OFBackButton.h"

@interface OFFormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    int count;
    NSString *formName;
    NSArray *myData;
    NSString *status;
    BOOL isEditing;
    NSMutableArray *textFields;
}

@property (strong, nonatomic) OFFormProgress *progressBar;
@property (strong, nonatomic) UITableView *myDataTable;
@property (strong, nonatomic) UIScrollView *horizontalScroll;
@property (strong, nonatomic) OFFormTitle *formTitle;
@property (strong, nonatomic) OFBackButton *backButton;

@end
