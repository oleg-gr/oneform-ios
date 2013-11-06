//
//  OFLoginViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OFLoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    UITextField *activeField;
    BOOL keyboardIsShown;
    BOOL isJoinScreen;
}

@property (nonatomic, strong) UIScrollView *scrollContainer;

@property (nonatomic, strong) UITextField *usernameTextfield;
@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UITextField *passwordTextfield;
@property (nonatomic, strong) UILabel *passwordLabel;

@property (nonatomic, strong) UITextField *emailTextfield;
@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, strong) UITextField *confirmPasswordTextfield;
@property (nonatomic, strong) UILabel *confirmPasswordLabel;

@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *signInButton;

@end
