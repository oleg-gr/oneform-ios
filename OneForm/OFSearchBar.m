//
//  OFSearchBar.m
//  OneForm
//
//  Created by Oleg Grishin on 11/23/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFSearchBar.h"
#define UI_HEIGHT 84.5

@implementation OFSearchBar

- (id)initWithBottomLabel:(NSString*)label
{
    self = [super initWithFrame:CGRectMake(0, 87, 320, UI_HEIGHT+43.5)];
    if (self) {
        [self setBackgroundColor:UI_COLOR_BACKGROUND_LIGHT];
        self.textFieldInteractionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 213.5f, UI_HEIGHT)];
        [self addSubview:self.textFieldInteractionView];
        self.searchButtonInteractionView = [[UIView alloc] initWithFrame:CGRectMake(213.5f, 0, 54.5f, UI_HEIGHT)];
        [self addSubview:self.searchButtonInteractionView];
        self.qrCodeInteractionView = [[UIView alloc] initWithFrame:CGRectMake(213.5f + 54.5f, 0, 52, UI_HEIGHT)];
        [self addSubview:self.qrCodeInteractionView];
        UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(228, 24, 35.25f, 40.75f)];
        [searchImage setImage:[UIImage imageNamed:@"search_icon.png"]];
        [self addSubview:searchImage];
        
        UIImageView *qrCodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(274.25f, 24, 32.75f, 32.75f)];
        [qrCodeImage setImage:[UIImage imageNamed:@"qr_code.png"]];
        [self addSubview:qrCodeImage];
        
        self.searchQuery = [[UITextField alloc] initWithFrame:CGRectMake(34.75f, 32.5f, 178.75f, 29.5)];
        [self.searchQuery setFont:[UIFont fontWithName:@"Roboto-Light" size:25]];
        [self.searchQuery setTextColor:UI_COLOR];
        [self.searchQuery setPlaceholder:@"search forms"];
        [self.searchQuery setAdjustsFontSizeToFitWidth:YES];
        [self.searchQuery setTintColor:UI_COLOR];
        [self.searchQuery setValue:UI_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:self.searchQuery];
        
        UITapGestureRecognizer *tapSearch =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(textFieldResponder)];
        [self.textFieldInteractionView addGestureRecognizer:tapSearch];
        
        UIView *bottomSign = [[UIView alloc] initWithFrame:CGRectMake(0, 87, 320, 43.5)];
        [bottomSign setBackgroundColor:UI_COLOR_BACKGROUND_DARK];
        [self addSubview:bottomSign];
        
        UILabel *bottomCaption = [[ UILabel alloc]
                           initWithFrame:CGRectMake(34.75f, 96.5f, 150, 30)];
        [bottomCaption setTextColor:UI_COLOR];
        [bottomCaption setFont:[UIFont fontWithName:@"Roboto-Regular" size:26]];
        [bottomCaption setText:label];
        [bottomCaption sizeToFit];
        [self addSubview:bottomCaption];

        
        
    }
    return self;
}

-(void)textFieldResponder
{
    [self.searchQuery becomeFirstResponder];
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
