//
//  OFFormViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFFormProgress.h"

@interface OFFormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSString *formName;
    NSMutableArray *myData;
    NSString *status;
    BOOL isEditing;
}

@property (strong, nonatomic) OFFormProgress *progressBar;
@property (strong, nonatomic) UITableView *myDataTable;

@end
