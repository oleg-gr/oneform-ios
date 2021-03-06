//
//  OFOrganizationsAccessViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFOrganizationsAccessViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *organizationsTable;
@property (strong, nonatomic) NSMutableArray *organizations;

-(id) initWithOrgs:(NSMutableArray*)orgs andUserData:(NSMutableDictionary*)userData;

@end
