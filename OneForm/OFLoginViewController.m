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
    self.scrollContainer.contentSize = CGSizeMake(320, 345);
    [self.view addSubview:self.scrollContainer];
    
    //textfield
    //design
    self.usernameTextfield = [[UITextField alloc]
                              initWithFrame:CGRectMake(85.0f, 270.0f, 150.0f, 30.0f)];
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
                          initWithFrame:CGRectMake(85.0f, 240.0f, 80.0f, 21.0f)];
    self.usernameLabel.text = @"Username";
    //logic
    [self.scrollContainer addSubview:self.usernameLabel];
    
    
    
    //PASSWORD
    
    //textfield
    //design
    self.passwordTextfield = [[UITextField alloc]
                              initWithFrame:CGRectMake(85.0f, 337.0f, 150.0f, 30.0f)];
    self.passwordTextfield.borderStyle = UITextBorderStyleRoundedRect;
    //logic
    self.passwordTextfield.secureTextEntry = YES;
    self.passwordTextfield.delegate = self;
    [self.scrollContainer addSubview:self.passwordTextfield];
    //label
    //design
    self.passwordLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(85.0f, 308.0f, 80.0f, 21.0f)];
    self.passwordLabel.text = @"Password";
    //logic
    [self.scrollContainer addSubview:self.passwordLabel];
    

    //KEYBOARD
    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Keyboard And Next Field Logic

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        [self.passwordTextfield becomeFirstResponder];
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
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 20, 0.0);
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
