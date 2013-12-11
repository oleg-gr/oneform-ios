//
//  OFSubmittingForm.h
//  OneForm
//
//  Created by Oleg Grishin on 12/11/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFFormProgress.h"


@interface OFSubmittingForm : UIViewController

@property (strong, nonatomic) NSMutableDictionary *userData;
@property (strong, nonatomic) NSMutableDictionary *formData;
@property (strong, nonatomic) NSMutableArray *myData;
@property (strong, nonatomic) OFFormProgress *progressBar;
@property (strong, nonatomic) AFHTTPRequestOperationManager *connectionManager;
@property (strong, nonatomic) UITextField *loading;

-(id)initWithUserData:(NSMutableDictionary*)userData andFields:(NSMutableArray*)myData andForm:(NSMutableDictionary*)formData;

@end
