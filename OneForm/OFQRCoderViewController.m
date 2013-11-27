//
//  OFQRCoderViewController.m
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFQRCoderViewController.h"
#import "SWRevealViewController.h"
#import "OFNavigationBar.h"
#import "OFBackButton.h"

@interface OFQRCoderViewController ()

@end

@implementation OFQRCoderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    OFNavigationBar *navBar = [[OFNavigationBar alloc] initWithRevealController:[self revealViewController]];
    
    [self.view addSubview:navBar];
    
    NSLog(@"QR CODE READER LOADED");
    
    OFBackButton *backButton = [[OFBackButton alloc] initWithFrame:CGRectMake(25, 85.5f, 110, 40) andLabel:@"go back"];
    
    [self.view addSubview:backButton];
    
    UITapGestureRecognizer *goBack =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goBack)];
    [backButton addGestureRecognizer:goBack];
    
    [self startCapturing];
    
    self.qrFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qr_frame"]];
    [self.qrFrame setFrame:CGRectMake(0, 0, 200, 200)];
    [self.qrFrame setCenter:CGPointMake(160, 160 + 150)];
    [self.qrFrame setAlpha:0.3];
    qrOut = nil;
    [self.qrFrame setUserInteractionEnabled:YES];
    UITapGestureRecognizer *catchQR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(getFormFromQR)];
    [self.qrFrame addGestureRecognizer:catchQR];
    [self.view addSubview:self.qrFrame];
    
    UILabel *tapPlus = [[UILabel alloc] initWithFrame:CGRectMake(0, 470, 320, 50)];
    [tapPlus setNumberOfLines:0];
    [tapPlus setTextAlignment:NSTextAlignmentCenter];
//    [tapPlus sizeToFit];
    [tapPlus setText:@"Tap + to scan QR code"];
    [tapPlus setFont:[UIFont fontWithName:@"Roboto-Light" size:27]];
    [tapPlus setTextColor:UI_COLOR];
    [self.view addSubview:tapPlus];
    
}

- (void) getFormFromQR
{
    NSLog(@"TOUCH");
    if (qrOut != nil)
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                          message:qrOut
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self goBack];
        //FORM DISPLAY LOGIC
    }
}

- (void) startCapturing
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device;
    for (AVCaptureDevice *each in devices)
    {
        if (each.position == AVCaptureDevicePositionBack)
        {
            device = each;
            break;
        }
    }
    if ([device lockForConfiguration:nil])
    {
        [device setAutoFocusRangeRestriction:AVCaptureAutoFocusRangeRestrictionNear];
    }
    [device unlockForConfiguration];
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    AVCaptureVideoPreviewLayer *preview = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [preview setFrame:CGRectMake(0, 130, 320, 320)];
    [self.view.layer addSublayer:preview];
    
    queue = dispatch_queue_create("camQueue", DISPATCH_QUEUE_SERIAL);
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:queue];
    if (input != nil)
    {
        [session addInput:input];
        [session addOutput:output];
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        [session startRunning];
    }
    else
    {
        //NO CAMERA LOGIC
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
        if ([metadataObjects count] < 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                qrOut = nil;
                [self.qrFrame setAlpha:0.3];
            });
            return;
        }
        for (id item in metadataObjects) {
            if ([item isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
                if (item) {
                    NSLog(@"%@", [item stringValue]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        qrOut = [item stringValue];
                        [self.qrFrame setAlpha:1.0];
                    });
                }
            }
        }
}

- (void) viewWillAppear:(BOOL)animated
{
    SWRevealViewController *revealController = [self revealViewController];
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

- (void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
