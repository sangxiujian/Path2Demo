//
//  HomeViewController.h
//  PathDemo
//
//  Created by HsiuJane Sang on 9/5/12.
//  Copyright (c) 2012 JiaYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SAViewPositionMiddle = 0,
    SAViewPositionLeft,
    SAViewPositionRight
}SAViewPosition;

@interface HomeViewController : UITableViewController<UIGestureRecognizerDelegate>{

    SAViewPosition _homeViewPosition;
}
@property (nonatomic,assign)SAViewPosition homeViewPosition;


@end
