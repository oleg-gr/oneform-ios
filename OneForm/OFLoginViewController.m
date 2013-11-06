//
//  OFLoginViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFLoginViewController.h"
#import "OFInternetUtility.h"

@interface OFLoginViewController ()

@end

@implementation OFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self registerForKeyboardNotifications];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //USERNAME
    
    //scrollview
    self.scrollContainer = [[UIScrollView alloc]
                            initWithFrame: self.view.frame];
    self.scrollContainer.contentSize = CGSizeMake(320, 380);
    [self.view addSubview:self.scrollContainer];
    
    //textfield
    //design
    self.usernameTextfield = [[UITextField alloc]
                              initWithFrame:CGRectMake(85.0, 270.0, 150.0, 30.0)];
    self.usernameTextfield.borderStyle = UITextBorderStyleRoundedRect;
    //logic
    self.usernameTextfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameTextfield.tag = 1;
    self.usernameTextfield.delegate = self;
    [self.scrollContainer addSubview:self.usernameTextfield];
    //label
    //design
    self.usernameLabel = [[ UILabel alloc]
                          initWithFrame:CGRectMake(85.0, 240.0, 150.0, 21.0)];
    self.usernameLabel.text = @"Username";
    //logic
    [self.scrollContainer addSubview:self.usernameLabel];
    
    
    
    //PASSWORD
    
    //textfield
    //design
    self.passwordTextfield = [[UITextField alloc]
                              initWithFrame:CGRectMake(85.0, 337.0, 150.0, 30.0)];
    self.passwordTextfield.borderStyle = UITextBorderStyleRoundedRect;
    //logic
    self.passwordTextfield.secureTextEntry = YES;
    self.passwordTextfield.delegate = self;
    self.passwordTextfield.tag = 2;
    [self.scrollContainer addSubview:self.passwordTextfield];
    
    //label
    //design
    self.passwordLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(85.0, 308.0, 150.0, 21.0)];
    self.passwordLabel.text = @"Password";
    //logic
    [self.scrollContainer addSubview:self.passwordLabel];

    
    
    //EMAIL
    
    //textfield
    //design
    self.emailTextfield = [[UITextField alloc]
                              initWithFrame:CGRectMake(320.0, 203.0, 150.0, 30.0)];
    self.emailTextfield.borderStyle = UITextBorderStyleRoundedRect;
    //logic
    self.emailTextfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailTextfield.delegate = self;
    self.emailTextfield.tag = 3;
    [self.scrollContainer addSubview:self.emailTextfield];
    
    //label
    //design
    self.emailLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(320.0, 174.0, 150.0, 21.0)];
    self.emailLabel.text = @"Email";
    //logic
    [self.scrollContainer addSubview:self.emailLabel];

    
    
    //CONFIRM PASSWORD
    
    //textfield
    //design
    self.confirmPasswordTextfield = [[UITextField alloc]
                           initWithFrame:CGRectMake(320.0, 404.0, 150.0, 30.0)];
    self.confirmPasswordTextfield.borderStyle = UITextBorderStyleRoundedRect;
    //logic
    self.confirmPasswordTextfield.secureTextEntry = YES;
    self.confirmPasswordTextfield.tag = 4;
    self.confirmPasswordTextfield.delegate = self;
    [self.scrollContainer addSubview:self.confirmPasswordTextfield];
    
    //label
    //design
    self.confirmPasswordLabel = [[UILabel alloc]
                       initWithFrame:CGRectMake(320.0, 375.0, 150.0, 21.0)];
    self.confirmPasswordLabel.text = @"Confirm password";
    //logic
    [self.scrollContainer addSubview:self.confirmPasswordLabel];
    
    
    
    //JOIN NOW
    
    //join now button
    //design
    self.joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.joinButton setTitle:@"First time?" forState:UIControlStateNormal];
    self.joinButton.frame = CGRectMake(85.0, 530.0, 150.0, 25.0);
    //logic
    [self.joinButton addTarget:self
                        action:@selector(joinAnimation)
              forControlEvents:UIControlEventTouchDown];
    [self.scrollContainer addSubview:self.joinButton];
    
    
    
    //SIGN IN
    
    //sign in button
    //design
    self.signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    self.signInButton.frame = CGRectMake(85.0, self.confirmPasswordLabel.frame.origin.y, 150.0, 25.0);
    //logic
    [self.signInButton addTarget:self
                    action:@selector(joinAnimation)
          forControlEvents:UIControlEventTouchDown];
    [self.scrollContainer addSubview:self.signInButton];
    

    
    //KEYBOARD
    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
    
    
    //ADDITIONAL SETUP
    isJoinScreen = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Text fields animation

- (void) joinAnimation
{
    CGRect emailFrame = self.emailTextfield.frame;
    CGRect emailLabelForm = self.emailLabel.frame;
    CGRect passwordFrame = self.confirmPasswordTextfield.frame;
    CGRect passwordLabelFrame = self.confirmPasswordLabel.frame;
    CGRect signInFrame = self.signInButton.frame;
    __block NSString *newJoinTitle;
    __block NSString *newSignInTitle;
    if (isJoinScreen)
    {
        emailFrame.origin.x = 320.0;
        emailLabelForm.origin.x = 320.0;
        passwordFrame.origin.x = 320.0;
        passwordLabelFrame.origin.x = 320.0;
        signInFrame.origin.y = self.confirmPasswordLabel.frame.origin.y;
        newJoinTitle = @"First time?";
        newSignInTitle = @"Sign in";
    } else
    {
        emailFrame.origin.x = 85.0;
        emailLabelForm.origin.x = 85.0;
        passwordFrame.origin.x = 85.0;
        passwordLabelFrame.origin.x = 85.0;
        signInFrame.origin.y = 440.0;
        newJoinTitle = @"Back to login";
        newSignInTitle = @"Join now";
    };
    
    isJoinScreen = !isJoinScreen;
    
    [UIButton animateWithDuration:0.3
                            delay:0.0
                          options:UIViewAnimationOptionCurveEaseIn
                       animations:^{
                           self.emailTextfield.frame = emailFrame;
                           self.emailLabel.frame = emailLabelForm;
                           self.confirmPasswordTextfield.frame = passwordFrame;
                           self.confirmPasswordLabel.frame = passwordLabelFrame;
                           self.signInButton.frame = signInFrame;
                           [self.joinButton setTitle:newJoinTitle forState:UIControlStateNormal];
                           [self.signInButton setTitle:newSignInTitle forState:UIControlStateNormal];
                       }
                       completion:nil];
}

#pragma mark Keyboard And Next Field Logic

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    int tag = textField.tag;
    if (tag == 1)
    {
        [self.passwordTextfield becomeFirstResponder];
    }
    else if (tag == 2)
    {
        if (isJoinScreen)
        {
            [self.confirmPasswordTextfield becomeFirstResponder];
        }
        else
        {
            //sign in logic
        }
    }
    if (tag == 3)
    {
        [self.usernameTextfield becomeFirstResponder];
    }
    if (tag == 4)
    {
        //sign up logic
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}

-(void)dismissKeyboard
{
    [self.usernameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.emailTextfield resignFirstResponder];
    [self.confirmPasswordTextfield resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollContainer.contentInset = contentInsets;
    self.scrollContainer.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollContainer scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollContainer.contentInset = contentInsets;
    self.scrollContainer.scrollIndicatorInsets = contentInsets;
}

@end
