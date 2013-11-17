//
//  OFTextField.m
//  OneForm
//
//  Created by Oleg Grishin on 11/14/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFTextField.h"

@implementation OFTextField

- (id)initWithFrame:(CGRect)frame andLabel:(NSString*) label
{
    self = [super initWithFrame:frame];
    if (self) {
        //text input
        self.textFieldInput = [[UITextField alloc]
                                  initWithFrame:CGRectMake(0, 30, 320 - 35, 40)];
        self.textFieldInput.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.textFieldInput];
        //label
        self.labelInput = [[ UILabel alloc]
                              initWithFrame:CGRectMake(0, 0, 150, 30)];
        self.labelInput.textColor = [UIColor whiteColor];
        self.labelInput.adjustsFontSizeToFitWidth = YES;
        self.labelInput.text = label;
        [self addSubview:self.labelInput];
        //line
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.textFieldInput.frame.size.height + self.labelInput.frame.size.height, self.textFieldInput.frame.size.width, 3)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
    }
    return self;
}

-(NSString *)getTextInput;
{
    return self.textFieldInput.text;
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
