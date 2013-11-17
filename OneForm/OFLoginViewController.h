//
//  OFLoginViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFTextField.h"

@interface OFLoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    UITextField *activeField;
    BOOL keyboardIsShown;
    BOOL isJoinScreen;
}

@property (nonatomic, strong) UIScrollView *scrollContainer;

@property (nonatomic, strong) OFTextField *usernameUI;

@property (nonatomic, strong) OFTextField *passwordUI;

@property (nonatomic, strong) OFTextField *firstNameUI;

@property (nonatomic, strong) OFTextField *lastNameUI;

@property (nonatomic, strong) OFTextField *emailUI;

@property (nonatomic, strong) OFTextField *confirmPasswordUI;

@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *signInButton;

-(void) signUpResponseLogic;
-(void) signInResponseLogic;

enum
{
    LEFT_ALIGN_LINE = 35,
    UI_ELEMENTS_GAP = 70
};

@end
