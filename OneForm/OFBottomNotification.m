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
        self.backgroundColor = [UIColor colorWithRed:96.0/255.0 green:100.0/255.0 blue:143.0/255.0 alpha:1.0];
        self.notification = [[ UILabel alloc]
                           initWithFrame:CGRectMake(0, 0, 320, height)];
        self.notification.center = CGPointMake(160.0, height/2);
        self.notification.textAlignment = NSTextAlignmentCenter;
        self.notification.textColor = [UIColor whiteColor];
        self.notification.font = [UIFont fontWithName:@"Roboto-Light" size:20];
        [self addSubview:self.notification];
    }
    return self;
}

-(void)showWithAutohide:(BOOL)autohide
{
    [self animate:[NSNumber numberWithInt:-1]];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (autohide)
    {
        [self performSelector:@selector(animate:) withObject:[NSNumber numberWithInt:1] afterDelay:2.0];
    }
}

-(void)hide
{
    [self animate:[NSNumber numberWithInt:1]];
}

-(void) animate:(NSNumber*) mode
{
    if([mode intValue ] == (self.isShown ? 1:-1))
    {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.center = CGPointMake(160.0, 568.0 + [mode intValue]*height/2);
                         }
                         completion:^(BOOL finished){
                             if([mode intValue] == -1)
                             {
                                 [self setIsShown:YES];
                             }
                             else
                             {
                                 [self setIsShown:NO];
                             }
                         }];
    }
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
