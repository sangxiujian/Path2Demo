//
//  AppDelegate.m
//  PathDemo
//
//  Created by HsiuJane Sang on 9/5/12.
//  Copyright (c) 2012 JiaYuan. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "HomeViewController.h"
#import "SaNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize navController = _navController;
@synthesize leftViewController = _leftViewController;
@synthesize rightViewController = _rightViewController;

- (void)dealloc
{
    [_navController release];
    [_leftViewController release];
    [_rightViewController release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
    LeftViewController *leftViewCtr = [[LeftViewController alloc] init];
    leftViewCtr.view.frame = CGRectMake(0, 20, 290, 460);
    self.leftViewController = leftViewCtr;
    [leftViewCtr release];
    
    RightViewController *rightViewCtr = [[RightViewController alloc] init];
    rightViewCtr.view.frame = CGRectMake(30, 20, 290, 460);
    self.rightViewController = rightViewCtr;
    [rightViewCtr release];
    
    HomeViewController *homeViewCtr = [[HomeViewController alloc] init];
    
    SaNavigationController *navCtr = [[SaNavigationController alloc] initWithRootViewController:homeViewCtr];
    [homeViewCtr release];
    self.navController = navCtr;
    [navCtr release];
    
    [self.window addSubview:self.leftViewController.view];
    [self.window addSubview:self.rightViewController.view];
    [self.window addSubview:self.navController.view];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
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


- (void)makeLeftViewVisible {
    self.navController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navController.view.layer.shadowOpacity = 0.4f;
    self.navController.view.layer.shadowOffset = CGSizeMake(-12.0, 1.0f);
    self.navController.view.layer.shadowRadius = 7.0f;
    self.navController.view.layer.masksToBounds = NO;
    self.leftViewController.view.hidden = NO;
    self.rightViewController.view.hidden = YES;

}

- (void)makeRightViewVisible {
    self.navController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navController.view.layer.shadowOpacity = 0.4f;
    self.navController.view.layer.shadowOffset = CGSizeMake(12.0, 1.0f);
    self.navController.view.layer.shadowRadius = 7.0f;
    self.navController.view.layer.masksToBounds = NO;
    self.leftViewController.view.hidden = YES;
    self.rightViewController.view.hidden = NO;

}

@end
