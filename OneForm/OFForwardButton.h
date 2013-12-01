//
//  OFForwardButton.h
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFForwardButton : UIView

@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UILabel *buttonLabel;

-(id)initWithFrame:(CGRect)frame andLabel:(NSString*) label;

@end
