//
//  OFSettingsViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFSettingsViewController.h"
#import "OFNavigationBar.h"
#import "OFFormTitle.h"

@interface OFSettingsViewController ()

@end

@implementation OFSettingsViewController

-(id) initWithUserData:(NSMutableArray*)userData;
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollContainer = [[TPKeyboardAvoidingScrollView alloc]
                            initWithFrame: self.view.frame];
    self.scrollContainer.contentSize = CGSizeMake(320, 548);
    [self.scrollContainer setContentOffset:CGPointMake(0,20)];
    
    [self.view addSubview:self.scrollContainer];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.scrollContainer addSubview:navBar];
    
    OFFormTitle *formTitle = [[OFFormTitle alloc] initWithYcoord:80 andTitle:@"Settings"];
    [self.scrollContainer addSubview:formTitle];
    
    UILabel *languageLabel = [[ UILabel alloc] initWithFrame:CGRectMake(30, 156, 320, 40)];
    [languageLabel setTextColor:UI_COLOR];
    [languageLabel setNumberOfLines:0];
    [languageLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:26]];
    [languageLabel setText:@"Select Language"];
    [languageLabel sizeToFit];
    [self.scrollContainer addSubview:languageLabel];
    
    self.english = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.english setTitle:@"English" forState:UIControlStateNormal];
    self.english.frame = CGRectMake(30, 194, 150.0, 40.0);
    [self.english setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [self.english.titleLabel setFont: [UIFont fontWithName:@"Roboto-Regular" size:18]];
    [self.english setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //logic
    [self.english setTag:1];
    [self.english addTarget:self
                          action:@selector(tapEnglish)
                forControlEvents:UIControlEventTouchDown];
    [self.scrollContainer addSubview:self.english];
    
    self.arabic = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.arabic setTitle:@"Arabic" forState:UIControlStateNormal];
    self.arabic.frame = CGRectMake(30, 227, 150.0, 40.0);
    [self.arabic setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [self.arabic.titleLabel setFont: [UIFont fontWithName:@"Roboto-Regular" size:18]];
    [self.arabic setAlpha:0.5];
    [self.arabic setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //logic
    [self.arabic setTag:0];
    [self.arabic addTarget:self
                     action:@selector(tapArabic)
           forControlEvents:UIControlEventTouchDown];
    [self.scrollContainer addSubview:self.arabic];
    
    UILabel *passwordLabel = [[ UILabel alloc] initWithFrame:CGRectMake(30, 275, 320, 40)];
    [passwordLabel setTextColor:UI_COLOR];
    [passwordLabel setNumberOfLines:0];
    [passwordLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:26]];
    [passwordLabel setText:@"Change Password"];
    [passwordLabel sizeToFit];
    [self.scrollContainer addSubview:passwordLabel];
    
    self.currentPassword = [[OFTextField alloc]
                       initWithFrame:CGRectMake(30, 320, 290, 60) andLabel:@"Current Password"];
    //logic
    self.currentPassword.textFieldInput.secureTextEntry = YES;
    self.currentPassword.textFieldInput.delegate = self;
    self.currentPassword.textFieldInput.tag = 2;
    [self.scrollContainer addSubview:self.currentPassword];
    
    self.aNewPassword = [[OFTextField alloc]
                            initWithFrame:CGRectMake(30, 380, 290, 60) andLabel:@"New Password"];
    //logic
    self.aNewPassword.textFieldInput.secureTextEntry = YES;
    self.aNewPassword.textFieldInput.delegate = self;
    self.aNewPassword.textFieldInput.tag = 3;
    [self.scrollContainer addSubview:self.aNewPassword];
    
    self.aNewConfirmPassword = [[OFTextField alloc]
                        initWithFrame:CGRectMake(30, 440, 290, 60) andLabel:@"Confirm New Password"];
    //logic
    self.aNewConfirmPassword.textFieldInput.secureTextEntry = YES;
    self.aNewConfirmPassword.textFieldInput.delegate = self;
    self.aNewConfirmPassword.textFieldInput.tag = 4;
    [self.scrollContainer addSubview:self.aNewConfirmPassword];
    
    self.save = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.save setTitle:@"Save changes" forState:UIControlStateNormal];
    self.save.frame = CGRectMake(0, 0, 250.0, 35.0);
    [self.save setCenter:CGPointMake(160, 530)];
    [self.save setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [self.save.titleLabel setFont: [UIFont fontWithName:@"Roboto-Light" size:26]];
    //logic
    [self.save addTarget:self
                          action:@selector(saveLogic)
                forControlEvents:UIControlEventTouchDown];
    [self.scrollContainer addSubview:self.save];
    
    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
    self.bottomNotification = [[OFBottomNotification alloc] initWithHeight: 69];
    [self.view addSubview:self.bottomNotification];
}

-(void)saveLogic
{
    if (self.currentPassword.textFieldInput.text.length == 0)
    {
        [self.bottomNotification.notification setText:@"Password cannot be empty"];
        [self.bottomNotification showWithAutohide:YES];
    }
    else if (self.aNewPassword.textFieldInput.text.length == 0)
    {
        [self.bottomNotification.notification setText:@"New password cannot be empty"];
        [self.bottomNotification showWithAutohide:YES];
    }
    else if (self.aNewConfirmPassword.textFieldInput.text.length == 0)
    {
        [self.bottomNotification.notification setText:@"New password confirmation cannot be empty"];
        [self.bottomNotification showWithAutohide:YES];
    }
    else if (![self.aNewConfirmPassword.textFieldInput.text isEqualToString:self.aNewPassword.textFieldInput.text])
    {
        [self.bottomNotification.notification setText:@"Passwords do not match"];
        [self.bottomNotification showWithAutohide:YES];
    }
}

-(void)tapEnglish
{
    if (self.english.tag == 0)
    {
        [self.english setTag:1];
        [self.english setAlpha:1];
        [self.arabic setTag:0];
        [self.arabic setAlpha:0.5];
    }
}

-(void)tapArabic
{
    if (self.arabic.tag == 0)
    {
        [self.arabic setTag:1];
        [self.arabic setAlpha:1];
        [self.english setTag:0];
        [self.english setAlpha:0.5];
    }
}

#pragma mark Keyboard And Next Field Logic

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    long tag = textField.tag;
    if (tag == 2)
    {
        [self.aNewPassword.textFieldInput becomeFirstResponder];
    }
    else if (tag == 3)
    {
        [self.aNewConfirmPassword.textFieldInput becomeFirstResponder];
    }
    else
    {
        [self saveLogic];
        [self dismissKeyboard];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    [self hideBottomNotifications];
}

-(void)dismissKeyboard
{
    [activeField resignFirstResponder];
    [self hideBottomNotifications];
    [self.scrollContainer setContentOffset:CGPointMake(0,0)];
}

- (void)hideBottomNotifications
{
    [self.bottomNotification hide];
}

-(void) viewWillAppear:(BOOL)animated
{
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
