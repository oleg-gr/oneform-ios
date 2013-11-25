//
//  OFSearchBar.h
//  OneForm
//
//  Created by Oleg Grishin on 11/23/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFSearchBar : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIView *textFieldInteractionView;
@property (nonatomic, strong) UIView *searchButtonInteractionView;
@property (nonatomic, strong) UIView *qrCodeInteractionView;
@property (nonatomic, strong) UITextField *searchQuery;

- (id)initWithBottomLabel:(NSString*)label;

@end
