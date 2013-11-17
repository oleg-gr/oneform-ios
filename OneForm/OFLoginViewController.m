//
//  OFLoginViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFLoginViewController.h"
#import "OFInternetUtility.h"
#import "OFHelperMethods.h"
#import "OFAppDelegate.h"
#import "OFTextField.h"

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
    
    //scrollview
    self.scrollContainer = [[UIScrollView alloc]
                            initWithFrame: self.view.frame];
    self.scrollContainer.contentSize = CGSizeMake(320, 380);
    [self.view addSubview:self.scrollContainer];
    
    
    //USERNAME
    //textfield
    //design
    self.usernameUI = [[OFTextField alloc]
                               initWithFrame:CGRectMake(LEFT_ALIGN_LINE, 270.0, 150.0, 60.0) andLabel:@"Username"];
    //logic
    self.usernameUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameUI.textFieldInput.tag = 1;
    self.usernameUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.usernameUI];
    //label
    //design
    //logic
    [self.scrollContainer addSubview:self.usernameUI];
    
    
    
    //PASSWORD
    
    //textfield
    //design
    self.passwordUI = [[OFTextField alloc]
                              initWithFrame:CGRectMake(LEFT_ALIGN_LINE, 340.0, 150.0, 60.0) andLabel:@"Password"];
    //logic
    self.passwordUI.textFieldInput.secureTextEntry = YES;
    self.passwordUI.textFieldInput.delegate = self;
    self.passwordUI.textFieldInput.tag = 2;
    [self.scrollContainer addSubview:self.passwordUI];
    [self.scrollContainer addSubview:self.passwordUI];

    
    
    //EMAIL
    
    //textfield
    //design
    self.emailUI = [[OFTextField alloc]
                    initWithFrame:CGRectMake(320.0, 210.0, 150.0, 60.0) andLabel:@"Email"];
    //logic
    self.emailUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailUI.textFieldInput.delegate = self;
    self.emailUI.textFieldInput.tag = 3;
    [self.scrollContainer addSubview:self.emailUI];
    
    
    //CONFIRM PASSWORD
    
    //textfield
    //design
    self.confirmPasswordUI = [[OFTextField alloc]
                       initWithFrame:CGRectMake(320.0, 400.0, 150.0, 60.0) andLabel:@"Confirm password"];
    //logic
    self.confirmPasswordUI.textFieldInput.secureTextEntry = YES;
    self.confirmPasswordUI.textFieldInput.tag = 4;
    self.confirmPasswordUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.confirmPasswordUI];
    
    
    
    
    //FIRST NAME
    
    //textfield
    //design
    self.firstNameUI = [[OFTextField alloc]
                              initWithFrame:CGRectMake(320.0, 90.0, 150.0, 60.0) andLabel:@"First Name"];
    //logic
    self.firstNameUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.firstNameUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.firstNameUI.textFieldInput.tag = 5;
    self.firstNameUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.firstNameUI];
    
    
    
    //LAST NAME
    
    //textfield
    //design
    self.lastNameUI = [[OFTextField alloc]
                        initWithFrame:CGRectMake(320.0, 150.0, 150.0, 60.0) andLabel:@"Last Name"];
    //logic
    self.lastNameUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.lastNameUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lastNameUI.textFieldInput.tag = 6;
    self.lastNameUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.lastNameUI];
    
    //JOIN NOW
    
    //join now button
    //design
    self.joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.joinButton setTitle:@"First time?" forState:UIControlStateNormal];
    self.joinButton.frame = CGRectMake(LEFT_ALIGN_LINE, 530.0, 150.0, 25.0);
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
    self.signInButton.frame = CGRectMake(LEFT_ALIGN_LINE, self.confirmPasswordUI.frame.origin.y, 150.0, 25.0);
    //logic
    [self.signInButton addTarget:self
                    action:@selector(signInButonAction)
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

#pragma mark Sign up and Sign in responses

-(void) signUpResponseLogic
{
    NSString *response = [OFHelperMethods signUp:[self.emailUI getTextInput]
                                    withUsername:[self.usernameUI getTextInput]
                                    withPassword:[self.passwordUI getTextInput]
                             withConfirmPassword:[self.confirmPasswordUI getTextInput]
                                   withFirstName:[self.firstNameUI getTextInput]
                                    withLastName:[self.lastNameUI getTextInput]
                          ];
    if (![response  isEqual: @"OK"]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Sign up failed"
                                                          message:response
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
        //data model assignment logic
    }
}

-(void) signInResponseLogic
{
    NSString *response = [OFHelperMethods signIn:[self.usernameUI getTextInput]
                                    withPassword:[self.passwordUI getTextInput]];
    if (![response  isEqual: @"OK"]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Sign in failed"
                                                          message:response
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
        OFAppDelegate *temp = (OFAppDelegate *)[[UIApplication sharedApplication] delegate];
        [self presentViewController:temp.revealController animated:YES completion:nil];
    }
}

#pragma mark Sign in adn Sign up button logic
- (void) signInButonAction
{
    if (isJoinScreen)
    {
        [self signUpResponseLogic];
    }
    else
    {
        [self signInResponseLogic];
    }
}

#pragma mark Text fields animation

- (void) joinAnimation
{
    CGRect emailFrame = self.emailUI.frame;
    CGRect passwordConfirmFrame = self.confirmPasswordUI.frame;
    CGRect firstNameFrame = self.firstNameUI.frame;
    CGRect lastNameFrame = self.lastNameUI.frame;
    CGRect signInFrame = self.signInButton.frame;
    __block NSString *newJoinTitle;
    __block NSString *newSignInTitle;
    if (isJoinScreen)
    {
        emailFrame.origin.x = 320.0;
        passwordConfirmFrame.origin.x = 320.0;
        firstNameFrame.origin.x = 320.0;
        lastNameFrame.origin.x = 320.0;
        signInFrame.origin.y = self.confirmPasswordUI.frame.origin.y;
        newJoinTitle = @"First time?";
        newSignInTitle = @"Sign in";
    } else
    {
        emailFrame.origin.x = LEFT_ALIGN_LINE;
        passwordConfirmFrame.origin.x = LEFT_ALIGN_LINE;
        firstNameFrame.origin.x = LEFT_ALIGN_LINE;
        lastNameFrame.origin.x = LEFT_ALIGN_LINE;
        signInFrame.origin.y = self.confirmPasswordUI.frame.origin.y + 60;
        newJoinTitle = @"Back to login";
        newSignInTitle = @"Join now";
    };
    
    isJoinScreen = !isJoinScreen;
    
    [UIButton animateWithDuration:0.3
                            delay:0.0
                          options:UIViewAnimationOptionCurveEaseIn
                       animations:^{
                           self.confirmPasswordUI.frame = passwordConfirmFrame;
                           self.firstNameUI.frame = firstNameFrame;
                           self.lastNameUI.frame = lastNameFrame;
                           self.emailUI.frame = emailFrame;
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
        [self.passwordUI.textFieldInput becomeFirstResponder];
    }
    else if (tag == 2)
    {
        if (isJoinScreen)
        {
            [self.confirmPasswordUI.textFieldInput becomeFirstResponder];
        }
        else
        {
            [self signInResponseLogic];
        }
    }
    else if (tag == 3)
    {
        [self.usernameUI.textFieldInput becomeFirstResponder];
    }
    else if (tag == 4)
    {
        [self signUpResponseLogic];
    }
    else if (tag == 5)
    {
        [self.lastNameUI.textFieldInput becomeFirstResponder];
    }
    else if (tag == 6)
    {
        [self.emailUI.textFieldInput becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}

-(void)dismissKeyboard
{
    [activeField resignFirstResponder];
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
