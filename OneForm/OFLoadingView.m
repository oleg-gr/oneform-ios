//
//  OFLoadingView.m
//  OneForm
//
//  Created by Oleg Grishin on 12/8/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFLoadingView.h"

@implementation OFLoadingView


- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 568)];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:0];
        [self setHidden:YES];
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.indicator setFrame:CGRectMake(0, 0, 200, 200)];
        [self.indicator setCenter:CGPointMake(160, 284)];
        [self addSubview:self.indicator];
        [self.indicator startAnimating];
    }
    return self;
}

- (void) show
{
    [UIView animateWithDuration:0.3
                            delay:0.0
                          options:UIViewAnimationOptionCurveEaseIn
                       animations:^{
                           [self setHidden:NO];//for ui blocking
                           [self setAlpha:0.8];
                       }
                       completion:nil];
}

- (void) hide
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self setHidden:YES];
                         [self setAlpha:0];
                     }
                     completion:nil];
    
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
