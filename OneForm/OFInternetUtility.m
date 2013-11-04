//
//  OFInternetUtility.m
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFInternetUtility.h"
#import "Reachability.h"

@implementation OFInternetUtility

+(void)checkInternetConnection {
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if (NO && (internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                          message:@"OneForm requires internet connection"
                                                         delegate:self
                                                cancelButtonTitle:@"Retry"
                                                otherButtonTitles:nil];
        [message show];
    }
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [OFInternetUtility checkInternetConnection];
    }
}

@end
