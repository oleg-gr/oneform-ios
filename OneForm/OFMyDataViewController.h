//
//  OFMyDataViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/30/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFMyDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *myData;
}

@property (strong, nonatomic) UIView *qrCodeInteractionView;
@property (strong, nonatomic) UITableView *myDataTable;

-(id) initWithUserData:(NSMutableDictionary*)userData;

@end
