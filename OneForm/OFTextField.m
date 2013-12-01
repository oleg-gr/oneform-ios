//
//  OFTextField.m
//  OneForm
//
//  Created by Oleg Grishin on 11/14/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFTextField.h"

@implementation OFTextField

-(id)initWithFrame:(CGRect)frame andLabel:(NSString*) label
{
    self = [self initWithFrame:frame andLabel:label andEditable:YES];
    return self;
}

- (id)initWithFrame:(CGRect)frame andLabel:(NSString*) label andEditable:(BOOL)isEdit
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
                              initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        [self.labelInput setTextColor:UI_COLOR];
        [self.labelInput setNumberOfLines:1];
        [self.labelInput setFont:[UIFont fontWithName:@"Roboto-Regular" size:18]];
        [self.labelInput setText:label];
        [self.labelInput sizeToFit];
        [self addSubview:self.labelInput];
        
        if (isEdit)
        {
            UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(singleTap)];
            [self addGestureRecognizer:singleFingerTap];
        }
        else
        {
            [self.textFieldInput setUserInteractionEnabled:NO];
        }
        
    }
    return self;
}

-(void)singleTap
{
    [self.textFieldInput becomeFirstResponder];
}

-(void)setLabelText:(NSString*)text
{
    [self.labelInput setText:text];
    [self.labelInput sizeToFit];
}

-(void)setTextFieldText:(NSString*)text
{
    [self.textFieldInput setText:text];
}

-(NSString *)getTextInput;
{
    return self.textFieldInput.text;
}

-(void)becomeFR
{
    [self.textFieldInput becomeFirstResponder];
}

-(void)resignFR
{
    [self.textFieldInput resignFirstResponder];
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
