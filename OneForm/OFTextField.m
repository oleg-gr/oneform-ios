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
        
        //line
        UIView *lineView = [[UIView alloc]
                            initWithFrame:CGRectMake(0, 49, self.frame.size.width, 1.5)];
        lineView.backgroundColor = UI_COLOR;
        [self addSubview:lineView];
        
        //text input
        self.textFieldInput = [[UITextField alloc]
                                  initWithFrame:CGRectMake(0, 26, self.frame.size.width, 21)];
        [self.textFieldInput setFont:[UIFont fontWithName:@"Roboto-Light" size:20]];
        [self.textFieldInput setTextColor:UI_COLOR];
        
        [self.textFieldInput setAdjustsFontSizeToFitWidth:YES];
        [self.textFieldInput setTintColor:UI_COLOR];
        
        [self addSubview:self.textFieldInput];
        
        //label
        self.labelInput = [[ UILabel alloc]
                              initWithFrame:CGRectMake(0, 0, 150, 30)];
        [self.labelInput setTextColor:UI_COLOR];
        [self.labelInput setNumberOfLines:0];
        [self.labelInput setFont:[UIFont fontWithName:@"Roboto-Regular" size:18]];
        [self.labelInput setText:label];
        [self.labelInput sizeToFit];
        [self addSubview:self.labelInput];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(singleTap)];
        [self addGestureRecognizer:singleFingerTap];
        
    }
    return self;
}

-(void)singleTap
{
    [self.textFieldInput becomeFirstResponder];
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
