//
//  OFNavigationBar.m
//  OneForm
//
//  Created by Oleg Grishin on 11/23/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFNavigationBar.h"
#import "SWRevealViewController.h"
#define TOP_ALIGN 24

@implementation OFNavigationBar

-(id) initWithRevealController: (SWRevealViewController*) revealController;
{
    self = [super initWithFrame:CGRectMake(0, 0, 320.0f, 96.5f)];
    if (self) {
        self.menuBars = [[UIButton alloc]  initWithFrame:CGRectMake(9, 31.5f, 33.5f, 19.5f)];
        [self.menuBars setImage:[UIImage imageNamed:@"menu_bars.png"] forState:UIControlStateNormal];
        [self addSubview:self.menuBars];
        if ([UIImage imageNamed:@"menu_bars.png"])
        {
            NSLog(@"asdasd");
        }
        [self.menuBars addTarget:revealController
                   action:@selector(revealToggle:)
         forControlEvents:UIControlEventTouchUpInside];
        
        
        self.oneFormLabelLeft = [[ UILabel alloc]
                                 initWithFrame:CGRectMake(102, TOP_ALIGN, 70, 30)];
        [self.oneFormLabelLeft setTextColor:UI_COLOR];
        [self.oneFormLabelLeft setFont:[UIFont fontWithName:@"Roboto-Light" size:30]];
        [self.oneFormLabelLeft setText:@"one"];
        [self.oneFormLabelLeft sizeToFit];
        [self addSubview:self.oneFormLabelLeft];
        
        
        self.oneFormLabelRight = [[ UILabel alloc]
                            initWithFrame:CGRectMake(151.5f, TOP_ALIGN, 70, 30)];
        [self.oneFormLabelRight setTextColor:UI_COLOR];
        [self.oneFormLabelRight setFont:[UIFont fontWithName:@"Roboto-Regular" size:30]];
        [self.oneFormLabelRight setText:@"Form"];
        [self.oneFormLabelRight sizeToFit];
        [self addSubview:self.oneFormLabelRight];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
