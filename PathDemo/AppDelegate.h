//
//  AppDelegate.h
//  PathDemo
//
//  Created by HsiuJane Sang on 9/5/12.
//  Copyright (c) 2012 JiaYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftViewController;
@class RightViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *navController;

@property (retain, nonatomic) LeftViewController *leftViewController;
@property (retain, nonatomic) RightViewController *rightViewController;


- (void)makeLeftViewVisible;
- (void)makeRightViewVisible;
@end
