//
//  OFBottomNotification.m
//  OneForm
//
//  Created by Oleg Grishin on 11/17/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFBottomNotification.h"

@implementation OFBottomNotification

-(id)initWithHeight:(float)initialHeight
{
    self = [super initWithFrame:CGRectMake(0.0, 568.0, 320.0, initialHeight)];
    height = initialHeight;
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.99];
        self.notification = [[ UILabel alloc]
                           initWithFrame:CGRectMake(0, 0, 320, height)];
        self.notification.center = CGPointMake(160.0, height/2);
        self.notification.textAlignment = NSTextAlignmentCenter;
        self.notification.textColor = [UIColor colorWithRed:44.0/255.0 green:24.0/255.0 blue:96.0/255.0 alpha:1.0];
        self.notification.font = [UIFont fontWithName:@"Roboto-Light" size:20];
        [self addSubview:self.notification];
    }
    return self;
}

-(void)show
{
    [self animate:-1];
    NSTimeInterval delay = 4.0;
    [self performSelector:@selector(animate:) withObject:[NSNumber numberWithInt:-1] afterDelay:delay];
}

-(void)hide
{
    [self animate:1];
}

-(void) animate:(int) mode
{
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.center = CGPointMake(160.0, 568.0 + mode*height/2);
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
