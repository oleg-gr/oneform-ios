//
//  OFNavigationBar.h
//  OneForm
//
//  Created by Oleg Grishin on 11/23/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface OFNavigationBar : UIView

@property (nonatomic, strong) UIButton *menuBars;
@property (nonatomic, strong) UILabel *oneFormLabelRight;
@property (nonatomic, strong) UILabel *oneFormLabelLeft;

-(id) initWithRevealController: (SWRevealViewController*) revealController;

@end
