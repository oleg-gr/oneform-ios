//
//  OFFormTitle.m
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFFormTitle.h"

@implementation OFFormTitle

- (id)initWithYcoord:(float)yCoord andTitle:(NSString*)label
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:184.0/255.0 green:186.0/255.0 blue:205/255.0 alpha:1.0]];
        UILabel *title = [[ UILabel alloc] initWithFrame:CGRectMake(0, yCoord, 246.5f, 50)];
        [title setTextColor:UI_COLOR];
        [title setNumberOfLines:0];
        [title setFont:[UIFont fontWithName:@"Roboto-Regular" size:26]];
        [title setText:label];
        [title sizeToFit];
        int numLines = (int)(title.frame.size.height/title.font.leading);
        float height = 18 + numLines*32;
        [self setFrame:CGRectMake(0, yCoord, 320, height)];
        [title setFrame:CGRectMake(0, 0, 246.5f, height)];
        [title setCenter:CGPointMake(123.25 + 36.5, height/2.0)];
        [self addSubview:title];
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
