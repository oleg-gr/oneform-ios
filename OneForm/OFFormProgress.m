//
//  OFFormProgress.m
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFFormProgress.h"

@implementation OFFormProgress

- (id)initWithFrame:(CGRect)frame andProgress:(float)progress andText:(NSString *)text andTextSize:(int)textSize andTextAlignment:(NSTextAlignment)alignment
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!textSize)
        {
            textSize = 26;
        }
        [self.layer setBorderWidth:2];
        [self.layer setBorderColor:UI_COLOR.CGColor];
        self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width*progress, frame.size.height)];
        [self.progressView setBackgroundColor:UI_COLOR_BACKGROUND_DARK];
        [self.progressView setClipsToBounds:YES];
        self.labelTop = [[UILabel alloc] initWithFrame: CGRectMake(11.25, 0, frame.size.width - 11.25*2, frame.size.height)];
        [self.labelTop setText:text];
        [self.labelTop setTextAlignment:alignment];
        [self.labelTop setTextColor:[UIColor whiteColor]];
        [self.labelTop setFont:[UIFont fontWithName:@"Roboto-Regular" size:textSize]];
        self.labelBottom = [[UILabel alloc] initWithFrame: CGRectMake(11.25, 0, frame.size.width - 11.25*2, frame.size.height)];
        [self.labelBottom setText:text];
        [self.labelBottom setTextAlignment:alignment];
        [self.labelBottom setTextColor:UI_COLOR];
        [self.labelBottom setFont:[UIFont fontWithName:@"Roboto-Regular" size:textSize]];
        [self addSubview:self.labelBottom];
        [self addSubview:self.progressView];
        [self.progressView addSubview:self.labelTop];
        
    }
    return self;
}

- (void)setText:(NSString*)text
{
    [self.labelTop setText:text];
    [self.labelBottom setText:text];
}

- (void)setProgress:(float)progress
{
    [self.progressView setFrame:CGRectMake(0, 0, self.frame.size.width*progress, self.progressView.frame.size.height)];
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
