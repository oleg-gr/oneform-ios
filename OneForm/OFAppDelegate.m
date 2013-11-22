//
//  OFAppDelegate.m
//  OneForm
//
//  Created by Oleg Grishin on 11/4/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFAppDelegate.h"
#import "OFLoginViewController.h"
#import "OFSearchFormsViewController.h"
#import "OFInternetUtility.h"
#import "OFMenuViewController.h"
#import "SWRevealViewController.h"

@interface OFAppDelegate()<SWRevealViewControllerDelegate>
@end

@implementation OFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    OFSearchFormsViewController *frontViewController= [[OFSearchFormsViewController alloc] init];
    OFMenuViewController *rearViewController = [[OFMenuViewController alloc] init];
	
	self.revealController = [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:frontViewController];
    
    //menu width
    self.revealController.rearViewRevealWidth = 175;
    self.revealController.rearViewRevealOverdraw = 175;
    self.revealController.draggableBorderWidth = 50;
    self.revealController.frontViewShadowRadius = 0;
    
    frontViewController.view.backgroundColor = [UIColor whiteColor];
    rearViewController.view.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:203.0/255.0 blue:216.0/255.0 alpha:1];
    
    self.revealController.delegate = self;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    OFLoginViewController *loginController = [[OFLoginViewController alloc] init];
    //self.window.rootViewController = loginController;
    self.window.rootViewController = self.revealController;
    [OFInternetUtility checkInternetConnection];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
