//
//  OFFormViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 12/1/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFFormProgress.h"
#import "OFFormTitle.h"
#import "OFBackButton.h"
#import "OFForwardButton.h"
#import "OFBottomNotification.h"
#import "OFHelperMethods.h"

@interface OFFormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    int count;
    int current;
    int counter;
    int previous;
    NSString *formName;
    NSMutableArray *myData;
    NSString *status;
    BOOL isEditing;
    BOOL initialScroll;
    NSMutableArray *textFields;
    UITextField *activefield;
    NSDateFormatter *df;
    float keyboardSize;
    BOOL isFromMySearch;
    BOOL isSubmitted;
}

@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UITableView *myDataTable;
@property (strong, nonatomic) UIScrollView *horizontalScroll;
@property (strong, nonatomic) OFFormTitle *formTitle;
@property (strong, nonatomic) OFBackButton *backButton;
@property (strong, nonatomic) OFForwardButton *forwardButton;
@property (strong, nonatomic) NSMutableDictionary *userData;
@property (strong, nonatomic) NSMutableDictionary *formData;
@property (strong, nonatomic) OFBottomNotification *bottomEditing;
@property (strong, nonatomic) OFBottomNotification *bottomNotEditing;
@property (strong, nonatomic) NSString *formId;


-(id)initWithUserData:(NSMutableDictionary*)userData andFormId:(NSString*)formId isSubmitted:(BOOL)isSub;

@end
