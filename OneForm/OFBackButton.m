//
//  OFBackButton.m
//  OneForm
//
//  Created by Oleg Grishin on 11/22/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFBackButton.h"

@implementation OFBackButton

- (id)initWithFrame:(CGRect)frame andLabel:(NSString*) label
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28.5f, 26)];
        [self.arrowImg setImage:[UIImage imageNamed:@"arrow_back.png"]];
        [self addSubview:self.arrowImg];
        
        self.buttonLabel = [[ UILabel alloc]
                           initWithFrame:CGRectMake(40, 0, frame.size.width - 30, 26)];
        self.buttonLabel.textColor = UI_COLOR;
        self.buttonLabel.numberOfLines = 0;
        self.buttonLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:18];
        self.buttonLabel.text = label;
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
