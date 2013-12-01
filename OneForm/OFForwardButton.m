//
//  OFForwardButton.m
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFForwardButton.h"

@implementation OFForwardButton

- (id)initWithFrame:(CGRect)frame andLabel:(NSString*) label
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 28.5f, 0, 28.5f, 26)];
        [self.arrowImg setImage:[UIImage imageNamed:@"arrow_forward.png"]];
        [self addSubview:self.arrowImg];
        
        self.buttonLabel = [[ UILabel alloc]
                            initWithFrame:CGRectMake(0, 0, frame.size.width - 40, 26)];
        self.buttonLabel.textColor = UI_COLOR;
        self.buttonLabel.numberOfLines = 0;
        self.buttonLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:18];
        self.buttonLabel.text = label;
        [self.buttonLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.buttonLabel];
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
