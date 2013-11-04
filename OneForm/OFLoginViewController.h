//
//  OFLoginViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFLoginViewController : UIViewController <UITextFieldDelegate> {
    UITextField *activeField;
    BOOL keyboardIsShown;
}

@property (nonatomic, strong) UIScrollView *scrollContainer;

@property (nonatomic, strong) UITextField *usernameTextfield;
@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UITextField *passwordTextfield;
@property (nonatomic, strong) UILabel *passwordLabel;

@end
