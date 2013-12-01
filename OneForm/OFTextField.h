//
//  OFTextField.h
//  OneForm
//
//  Created by Oleg Grishin on 11/14/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFTextField : UIView

@property (nonatomic, strong) UITextField *textFieldInput;
@property (nonatomic, strong) UILabel *labelInput;

-(id)initWithFrame:(CGRect)frame andLabel:(NSString*) label;
-(id)initWithFrame:(CGRect)frame andLabel:(NSString*) label andEditable:(BOOL) isEdit;
-(NSString*)getTextInput;
-(void)setLabelText:(NSString*)text;
-(void)setTextFieldText:(NSString*)text;

@end
