//
//  OFLoginViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFTextField.h"
#import "OFBottomNotification.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "OFBackButton.h"
#import "SWRevealViewController.h"
#import "OFLoadingView.h"

@interface OFLoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    UITextField *activeField;
    BOOL keyboardIsShown;
    BOOL isJoinScreen;
}

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollContainer;

@property (nonatomic, strong) OFTextField *passwordUI;

@property (nonatomic, strong) OFTextField *firstNameUI;

@property (nonatomic, strong) OFTextField *lastNameUI;

@property (nonatomic, strong) OFTextField *udidUI;

@property (nonatomic, strong) OFTextField *emailUI;

@property (nonatomic, strong) OFTextField *confirmPasswordUI;

@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *signInButton;

@property (nonatomic, strong) OFBottomNotification *bottomNotificationSignIn;
@property (nonatomic, strong) OFBottomNotification *bottomNotificationSignUp;

@property (nonatomic, strong) OFBackButton *backToSignIn;

@property (strong, nonatomic) SWRevealViewController *revealController;

@property (strong, nonatomic) UIImageView *mainIcon;

@property (strong, nonatomic) AFHTTPRequestOperationManager *connectionManager;

@property (strong, nonatomic) OFLoadingView *loadingView;

-(void) signUpResponseLogic;
-(void) signInResponseLogic;

@end
