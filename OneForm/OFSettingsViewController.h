//
//  OFSettingsViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "OFTextField.h"
#import "OFBottomNotification.h"

@interface OFSettingsViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *activeField;
}

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollContainer;

@property (strong, nonatomic) UIButton *english;
@property (strong, nonatomic) UIButton *arabic;
@property (strong, nonatomic) OFTextField *currentPassword;
@property (strong, nonatomic) OFTextField *aNewPassword;//new is a cocoa synthesize convention keyword
@property (strong, nonatomic) OFTextField *aNewConfirmPassword;
@property (strong, nonatomic) UIButton *save;
@property (strong, nonatomic) OFBottomNotification *bottomNotification;

@end
