//
//  OFFormProgress.h
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFFormProgress : UIView

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UILabel *labelTop;
@property (nonatomic, strong) UILabel *labelBottom;

- (id)initWithFrame:(CGRect)frame andProgress:(float)progress andText:(NSString *)text andTextSize:(int)textSize andTextAlignment:(NSTextAlignment)alignment;
//default text size is 26

- (void)setText:(NSString*)text;
- (void)setProgress:(float)progress;

@end
