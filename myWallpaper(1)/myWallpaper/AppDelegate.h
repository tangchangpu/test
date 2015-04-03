//
// mmmmm  AppDelegate.h
//  myWallpaper
//
//  Created by wangzijie on 15/1/28.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRSideViewController.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) YRSideViewController *sideViewController;

@end

