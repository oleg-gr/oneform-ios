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
#import "OFBackButton.h"
#import "OFSearchFormsViewController.h"
#import "OFMenuViewController.h"

#define LEFT_ALIGN_LINE 35
#define UI_ELEMENTS_GAP 68
#define UI_TEXT_WIDTH 320 - LEFT_ALIGN_LINE

@interface OFLoginViewController ()<SWRevealViewControllerDelegate>

@end

@implementation OFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollview
    self.scrollContainer = [[TPKeyboardAvoidingScrollView alloc]
                            initWithFrame: self.view.frame];
    self.scrollContainer.contentSize = CGSizeMake(320, 568);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollContainer];
    
    
    //USERNAME (became EMAIL)
    //textfield
    //design
    self.emailUI = [[OFTextField alloc]
                               initWithFrame:CGRectMake(LEFT_ALIGN_LINE, 280.0, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"Email"];
    //logic
    self.emailUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailUI.textFieldInput.tag = 1;
    self.emailUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.emailUI];
    
    
    
    //PASSWORD
    
    //textfield
    //design
    self.passwordUI = [[OFTextField alloc]
                              initWithFrame:CGRectMake(LEFT_ALIGN_LINE, self.emailUI.frame.origin.y + UI_ELEMENTS_GAP, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"Password"];
    //logic
    self.passwordUI.textFieldInput.secureTextEntry = YES;
    self.passwordUI.textFieldInput.delegate = self;
    self.passwordUI.textFieldInput.tag = 2;
    [self.scrollContainer addSubview:self.passwordUI];

    
    
    //EMAIL
    
    //textfield
    //design
//    self.emailUI = [[OFTextField alloc]
//                    initWithFrame:CGRectMake(320.0, self.usernameUI.frame.origin.y - UI_ELEMENTS_GAP, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"Email"];
//    //logic
//    self.emailUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    self.emailUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
//    self.emailUI.textFieldInput.delegate = self;
//    self.emailUI.textFieldInput.tag = 3;
//    [self.scrollContainer addSubview:self.emailUI];
    
    //UDID
    //textfield
    //design
    self.udidUI = [[OFTextField alloc]
                    initWithFrame:CGRectMake(320.0, self.emailUI.frame.origin.y - UI_ELEMENTS_GAP, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"UDID"];
    //logic
    self.udidUI.textFieldInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.udidUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.udidUI.textFieldInput.tag = 7;
    self.udidUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.udidUI];
    
    
    //CONFIRM PASSWORD
    
    //textfield
    //design
    self.confirmPasswordUI = [[OFTextField alloc]
                       initWithFrame:CGRectMake(320.0, self.emailUI.frame.origin.y + UI_ELEMENTS_GAP*2, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"Confirm password"];
    //logic
    self.confirmPasswordUI.textFieldInput.secureTextEntry = YES;
    self.confirmPasswordUI.textFieldInput.tag = 4;
    self.confirmPasswordUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.confirmPasswordUI];
    
    
    
    
    //FIRST NAME
    
    //textfield
    //design
    self.firstNameUI = [[OFTextField alloc]
                              initWithFrame:CGRectMake(320.0, self.emailUI.frame.origin.y - UI_ELEMENTS_GAP*3, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"First Name"];
    //logic
    self.firstNameUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.firstNameUI.textFieldInput.tag = 5;
    self.firstNameUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.firstNameUI];
    
    
    
    //LAST NAME
    
    //textfield
    //design
    self.lastNameUI = [[OFTextField alloc]
                        initWithFrame:CGRectMake(320.0, self.emailUI.frame.origin.y - UI_ELEMENTS_GAP*2, UI_TEXT_WIDTH, UI_ELEMENTS_GAP) andLabel:@"Last Name"];
    //logic
    self.lastNameUI.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lastNameUI.textFieldInput.tag = 6;
    self.lastNameUI.textFieldInput.delegate = self;
    [self.scrollContainer addSubview:self.lastNameUI];
    
    //JOIN NOW
    //join now button
    //design
    self.joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.joinButton setTitle:@"first time?" forState:UIControlStateNormal];
    self.joinButton.frame = CGRectMake(0, 0, 130, 50);
    self.joinButton.center = CGPointMake(160.0, 546.0);
    [self.joinButton setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [self.joinButton.titleLabel setFont: [UIFont fontWithName:@"Roboto-Thin" size:21]];
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
    self.signInButton.frame = CGRectMake(0, 0, 150.0, 45.0);
    self.signInButton.center = CGPointMake(160.0, self.passwordUI.frame.origin.y + 120);
    [self.signInButton setTitleColor:UI_COLOR forState:UIControlStateNormal];
    [self.signInButton.titleLabel setFont: [UIFont fontWithName:@"Roboto-Thin" size:36]];
    //logic
    [self.signInButton addTarget:self
                    action:@selector(signInButonAction)
          forControlEvents:UIControlEventTouchDown];
    [self.scrollContainer addSubview:self.signInButton];
    
    
    
    //GO BACK BUTTON
    self.backToSignIn = [[OFBackButton alloc] initWithFrame:CGRectMake(25, 32.5f, 110, 40) andLabel:@"go back"];
    UITapGestureRecognizer *backToSignInTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(joinAnimation)];
    [self.backToSignIn addGestureRecognizer:backToSignInTap];
    [self.backToSignIn setHidden:YES];
    [self.scrollContainer addSubview:self.backToSignIn];
    
    //MAIN ICON
    
    self.mainIcon = [[UIImageView alloc] initWithFrame:CGRectMake(81, 122, 161, 89.5)];
    [self.mainIcon setImage:[UIImage imageNamed:@"main_screen_icon.png"]];
    [self.scrollContainer addSubview:self.mainIcon];
    
    //KEYBOARD
    UITapGestureRecognizer *tapOutOfText = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [tapOutOfText setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapOutOfText];
    
    
    
    //ADDITIONAL SETUP
    isJoinScreen = NO;
    
    self.bottomNotificationSignIn = [[OFBottomNotification alloc] initWithHeight: 69];
    [self.view addSubview:self.bottomNotificationSignIn];
    self.bottomNotificationSignUp = [[OFBottomNotification alloc] initWithHeight: 84];
    [self.view addSubview:self.bottomNotificationSignUp];
 
    self.connectionManager = [AFHTTPRequestOperationManager manager];
    [self.connectionManager.securityPolicy setAllowInvalidCertificates:YES];
    [self.connectionManager setRequestSerializer: [AFJSONRequestSerializer serializer]];
    
    self.loadingView = [[OFLoadingView alloc] init];
    [self.scrollContainer addSubview:self.loadingView];
    //FOR INITIAL TESTING
    [self.emailUI.textFieldInput setText:@"moiri@oneform.in"];
    [self.passwordUI.textFieldInput setText:@"password"];
}

- (void)didReceiveMemoryWarningisNotificationisNotificationisNotification
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Sign up and Sign in responses

-(void) signUpResponseLogic
{
    NSString *fieldsCheck = [OFHelperMethods signUp:[self.emailUI getTextInput]
                                    withPassword:[self.passwordUI getTextInput]
                             withConfirmPassword:[self.confirmPasswordUI getTextInput]
                                   withFirstName:[self.firstNameUI getTextInput]
                                    withLastName:[self.lastNameUI getTextInput]
                                        withUdid:[self.udidUI getTextInput]
                          ];
    if ([fieldsCheck isEqualToString:@"OK"])
    {
        NSString *shaReq = [NSString stringWithFormat:@"%@%@%@", [self.emailUI getTextInput], MY_DOMAIN, [self.passwordUI getTextInput]];
        NSDictionary *parameters = @{@"email": [self.emailUI getTextInput],
                                     @"secret": [OFHelperMethods createSHA512:shaReq],
                                     @"firstName": [self.firstNameUI getTextInput],
                                     @"lastName": [self.lastNameUI getTextInput],
                                     @"profileId": [self.udidUI getTextInput]}; //change param to UDID when the API is changed
        NSString *route = [NSString stringWithFormat:@"%@%@", SERVER, @"/users"];
        
        [self buildData:route withParams:parameters isSignIn:NO];
    }
    else
    {
        [self.bottomNotificationSignUp.notification setText:fieldsCheck];
        [self.bottomNotificationSignUp showWithAutohide:YES];
    }
}

-(void) buildData:(NSString*)route withParams:(NSDictionary*)parameters isSignIn:(BOOL)isSignIn
{
    [self.loadingView show];
    
    __block NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
    __block int status;
    
    [self.connectionManager POST:route parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        status = (int) [[responseObject objectForKey:@"status"] integerValue];
        
        if (status == 200)
        {
            __block NSString *newRoute = [NSString stringWithFormat:@"%@%@", SERVER, @"/forms"];
            
            [response setObject:[responseObject objectForKey:@"result"] forKey:@"user"];
            
            [self.connectionManager GET:newRoute parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if ((int) [[responseObject objectForKey:@"status"] integerValue] == 200)
                {
                    [response setObject:[responseObject objectForKey:@"result"] forKey:@"forms"];
                    
                    newRoute = [NSString stringWithFormat:@"%@%@", SERVER, @"/orgs"];
                    
                    [self.connectionManager GET:newRoute parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        if ((int) [[responseObject objectForKey:@"status"] integerValue] == 200)
                        {
                            [response setObject:[responseObject objectForKey:@"result"] forKey:@"orgs"];
                            [response setObject:[OFHelperMethods orgToLookup:[responseObject objectForKey:@"result"]] forKey:@"orgs_lookup"];
                            NSLog(@"%@", response);
                            if (isSignIn)
                            {
                                [self signIn:response andStatus:status];
                            }
                            else
                            {
                                [self signUp:response andStatus:status];
                            }
                        }
                        else
                        {
                            [self signError:isSignIn];
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
                        [self signError:isSignIn];
                    }];
                }
                else
                {
                    [self signError:isSignIn];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
                [self signError:isSignIn];
            }];
        }
        else
        {
            if (isSignIn)
            {
                [self signIn:nil andStatus:status];
            }
            else
            {
                [self signUp:nil andStatus:status];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        [self signError:isSignIn];
    }];
}

-(void)signError:(BOOL)isSignIn
{
    if (isSignIn)
    {
        [self signIn:nil andStatus:-200];
    }
    else
    {
        [self signUp:nil andStatus:-200];
    }
}

-(void) signInResponseLogic
{
    NSString *fieldsCheck = [OFHelperMethods signIn:[self.emailUI getTextInput] withPassword:[self.passwordUI getTextInput]];
    
    if ([fieldsCheck isEqualToString:@"OK"])
    {
        NSString *shaReq = [NSString stringWithFormat:@"%@%@%@", [self.emailUI getTextInput], MY_DOMAIN, [self.passwordUI getTextInput]];
        NSDictionary *parameters = @{@"email": [self.emailUI getTextInput],
                                     @"secret": [OFHelperMethods createSHA512:shaReq]};
        NSString *route = [NSString stringWithFormat:@"%@%@", SERVER, @"/auth/users"];
        
        [self buildData:route withParams:parameters isSignIn:YES];
    }
    else
    {
        [self.bottomNotificationSignIn.notification setText:fieldsCheck];
        [self.bottomNotificationSignIn showWithAutohide:YES];
    }
    
}

- (void)signUp:(NSMutableDictionary*)userData andStatus:(int)status
{
    [self.loadingView hide];
    if (status == 200)
    {
        [self showMainScreen:userData];
    }
}

- (void)signIn:(NSMutableDictionary*)userData andStatus:(int)status
{
    [self.loadingView hide];
    if (status == 200)
    {
        [self showMainScreen:userData];
    }
    else {
        if (status == 404)
        {
            [self.bottomNotificationSignIn.notification setText:@"Account with this email does not exist"];
        }
        else if (status == 401)
        {
            [self.bottomNotificationSignIn.notification setText:@"Wrong password"];
        }
        else
        {
            [self.bottomNotificationSignIn.notification setText:@"Error occured"];
        }
        [self.bottomNotificationSignIn showWithAutohide:YES];
   }
}

- (void)showMainScreen:(NSMutableDictionary*)userData
{
    [self.passwordUI setTextFieldText:@""];
    [self.firstNameUI setTextFieldText:@""];
    [self.lastNameUI setTextFieldText:@""];
    [self.udidUI setTextFieldText:@""];
    [self.emailUI setTextFieldText:@""];
    [self.confirmPasswordUI setTextFieldText:@""];

    OFMenuViewController *rearViewController = [[OFMenuViewController alloc] initWithUserData: userData];
    OFSearchFormsViewController *searchController= rearViewController.searchController;
    //[[OFSearchFormsViewController alloc] initWithUserData:userData]
    
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:searchController];
    
    self.revealController = [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:frontViewController];
    
    //menu width
    self.revealController.rearViewRevealWidth = 175;
    self.revealController.rearViewRevealOverdraw = 175;
    self.revealController.draggableBorderWidth = 50;
    self.revealController.frontViewShadowRadius = 0;
    
    frontViewController.view.backgroundColor = [UIColor whiteColor];
    rearViewController.view.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:203.0/255.0 blue:216.0/255.0 alpha:1];
    self.revealController.delegate = self;
    [self.revealController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:self.revealController animated:YES completion:nil];
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
    CGRect passwordConfirmFrame = self.confirmPasswordUI.frame;
    CGRect firstNameFrame = self.firstNameUI.frame;
    CGRect lastNameFrame = self.lastNameUI.frame;
    CGRect udidFrame = self.udidUI.frame;
    CGPoint signInCenter;
    __block NSString *newSignInTitle;
    if (isJoinScreen)
    {
        passwordConfirmFrame.origin.x = 320.0;
        firstNameFrame.origin.x = 320.0;
        lastNameFrame.origin.x = 320.0;
        udidFrame.origin.x = 320.0;
        signInCenter = CGPointMake(160.0, self.passwordUI.frame.origin.y + 120);
        newSignInTitle = @"Sign in";
    } else
    {
        passwordConfirmFrame.origin.x = LEFT_ALIGN_LINE;
        firstNameFrame.origin.x = LEFT_ALIGN_LINE;
        lastNameFrame.origin.x = LEFT_ALIGN_LINE;
        udidFrame.origin.x = LEFT_ALIGN_LINE;
        signInCenter = CGPointMake(160.0, self.confirmPasswordUI.frame.origin.y + 104);
        newSignInTitle = @"Join now";
        [self.mainIcon setHidden:YES];
    };
    
    isJoinScreen = !isJoinScreen;
    
    [UIButton animateWithDuration:0.3
                            delay:0.0
                          options:UIViewAnimationOptionCurveEaseIn
                       animations:^{
                           self.confirmPasswordUI.frame = passwordConfirmFrame;
                           self.firstNameUI.frame = firstNameFrame;
                           self.lastNameUI.frame = lastNameFrame;
                           self.udidUI.frame = udidFrame;
                           self.signInButton.center = signInCenter;
                           //[self.joinButton setTitle:newJoinTitle forState:UIControlStateNormal];
                           [self.joinButton setHidden:isJoinScreen];
                           [self.backToSignIn setHidden:!isJoinScreen];
                           [self.signInButton setTitle:newSignInTitle forState:UIControlStateNormal];
                       }
                       completion:^(BOOL finished){
                           if (finished && !isJoinScreen)
                           {
                               [self.mainIcon setHidden:NO];
                           }
                       }];
}

#pragma mark Keyboard And Next Field Logic

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    long tag = textField.tag;
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
            [textField resignFirstResponder];
            [self signInResponseLogic];
        }
    }
    else if (tag == 4)
    {
        [textField resignFirstResponder];
        [self signUpResponseLogic];
    }
    else if (tag == 5)
    {
        [self.lastNameUI.textFieldInput becomeFirstResponder];
    }
    else if (tag == 6)
    {
        [self.udidUI.textFieldInput becomeFirstResponder];
    }
    else if (tag == 7)
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
    [self hideBottomNotifications];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    [self hideBottomNotifications];
}

- (void)hideBottomNotifications
{
    if (isJoinScreen)
    {
        [self.bottomNotificationSignUp hide];
    }
    else
    {
        [self.bottomNotificationSignIn hide];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

@end
