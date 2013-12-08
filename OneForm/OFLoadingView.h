//
//  OFLoadingView.h
//  OneForm
//
//  Created by Oleg Grishin on 12/8/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFLoadingView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

- (id)init;
- (void)show;
- (void)hide;

@end
