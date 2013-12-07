//
//  OFDoubleSearch.h
//  OneForm
//
//  Created by Oleg Grishin on 12/8/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFDoubleSearch : UIView

@property (nonatomic, strong) UIView *textFieldInteractionView;
@property (nonatomic, strong) UITextField *searchQuery;
@property (nonatomic, strong) UITextField *secondSearchQuery;
@property (nonatomic, strong) UIView *secondTextFieldInteractionView;


- (id)initWithTopPlaceholder:(NSString*)top andBottom:(NSString*)bottom;

@end
