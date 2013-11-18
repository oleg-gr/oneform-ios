//
//  OFBottomNotification.h
//  OneForm
//
//  Created by Oleg Grishin on 11/17/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFBottomNotification : UIView
{
    float height;
}

-(id)initWithHeight:(float)height;
-(void)show;
-(void)hide;

@property (nonatomic, strong) UILabel *notification;
@property BOOL isShown;

@end
