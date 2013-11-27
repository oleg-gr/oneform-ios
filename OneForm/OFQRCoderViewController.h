//
//  OFQRCoderViewController.h
//  OneForm
//
//  Created by Oleg Grishin on 11/25/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface OFQRCoderViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
{
    dispatch_queue_t queue;
    NSArray *lastCorners;
    NSString *qrOut;
}

@property (strong, nonatomic) UIImageView *qrFrame;

@end
