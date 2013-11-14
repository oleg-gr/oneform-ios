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
        self.textFieldInput = [[UITextField alloc]
                                  initWithFrame:CGRectMake(0, 30, 150, 30)];
        self.textFieldInput.borderStyle = UITextBorderStyleRoundedRect;
        //logic
        [self addSubview:self.textFieldInput];
        //label
        //design
        self.labelInput = [[ UILabel alloc]
                              initWithFrame:CGRectMake(0, 0, 150, 20)];
        self.labelInput.text = label;
        [self addSubview:self.labelInput];
        
        
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
