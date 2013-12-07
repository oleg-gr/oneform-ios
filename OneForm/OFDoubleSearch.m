//
//  OFDoubleSearch.m
//  OneForm
//
//  Created by Oleg Grishin on 12/8/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFDoubleSearch.h"

#define UI_HEIGHT 84.5

@implementation OFDoubleSearch

- (id)initWithTopPlaceholder:(NSString*)top andBottom:(NSString*)bottom
{
    self = [super initWithFrame:CGRectMake(0, 87, 320, UI_HEIGHT+43.5)];
    if (self) {
        [self setBackgroundColor:UI_COLOR_BACKGROUND_LIGHT];
        
        float textfieldWidth = 235;
        
        self.textFieldInteractionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textfieldWidth - 34.75f, UI_HEIGHT)];
        [self addSubview:self.textFieldInteractionView];
        UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(textfieldWidth + 15, 24, 35.25f, 40.75f)];
        [searchImage setImage:[UIImage imageNamed:@"search_icon.png"]];
        [self addSubview:searchImage];
        
        self.searchQuery = [[UITextField alloc] initWithFrame:CGRectMake(34.75f, 32.5f, textfieldWidth, 29.5f)];
        [self.searchQuery setFont:[UIFont fontWithName:@"Roboto-Light" size:25]];
        [self.searchQuery setTextColor:UI_COLOR];
        [self.searchQuery setPlaceholder:top];
        [self.searchQuery setAdjustsFontSizeToFitWidth:YES];
        [self.searchQuery setTintColor:UI_COLOR];
        [self.searchQuery setValue:UI_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:self.searchQuery];
        
        UITapGestureRecognizer *tapSearch =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(textFieldResponder)];
        [self.textFieldInteractionView addGestureRecognizer:tapSearch];
        
        self.secondTextFieldInteractionView = [[UIView alloc] initWithFrame:CGRectMake(0, 87, 320, 43.5)];
        [self.secondTextFieldInteractionView setBackgroundColor:UI_COLOR_BACKGROUND_DARK];
        [self addSubview:self.secondTextFieldInteractionView];
        
        UITapGestureRecognizer *tapSearchAgency =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(textFieldResponderAgency)];
        [self.secondTextFieldInteractionView addGestureRecognizer:tapSearchAgency];
        
        self.secondSearchQuery = [[UITextField alloc] initWithFrame:CGRectMake(34.75f, 96.5f, textfieldWidth - 34.75f, 30)];
        [self.secondSearchQuery setTextColor:UI_COLOR];
        [self.secondSearchQuery setFont:[UIFont fontWithName:@"Roboto-Regular" size:26]];
        [self.secondSearchQuery setPlaceholder:bottom];
        [self.secondSearchQuery setAdjustsFontSizeToFitWidth:YES];
        [self.secondSearchQuery setValue:UI_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:self.secondSearchQuery];
        
        UIImageView *searchImageAgency = [[UIImageView alloc] initWithFrame:CGRectMake(textfieldWidth + 15, 96.5, 25, 28.75f)];
        [searchImageAgency setImage:[UIImage imageNamed:@"search_icon.png"]];
        [self addSubview:searchImageAgency];
    }
    return self;
}

-(void)textFieldResponder
{
    [self.searchQuery becomeFirstResponder];
}

-(void)textFieldResponderAgency
{
    [self.secondSearchQuery becomeFirstResponder];
}

@end