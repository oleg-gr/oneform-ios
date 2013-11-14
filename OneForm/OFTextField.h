//
//  OFTextField.h
//  OneForm
//
//  Created by Oleg Grishin on 11/14/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFTextField : UIView

-(id)initWithFrame:(CGRect)frame andLabel:(NSString*) label;

@property (nonatomic, strong) UITextField *textFieldInput;
@property (nonatomic, strong) UILabel *labelInput;

-(NSString*)getTextInput;

@end
