//
//  AppDelegate.m
//  myWallpaper
//
//  Created by wangzijie on 15/1/28.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ListController.h"
#import "FunctionController.h"
#import "WXApi.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController *viewVC = [[ViewController alloc] init];
    ListController *listVC = [[ListController alloc] init];
    FunctionController *functionVC = [[FunctionController alloc] init];
    
    self.sideViewController = [[YRSideViewController alloc] init];
    self.sideViewController.rootViewController = viewVC;
    self.sideViewController.leftViewShowWidth = IMAGE_WIDTH;
    self.sideViewController.rightViewShowWidth = IMAGE_WIDTH;
    self.sideViewController.leftViewController = listVC;
    self.sideViewController.rightViewController = functionVC;
    self.sideViewController.needSwipeShowMenu = true;
    
    self.window.rootViewController = self.sideViewController;
    
    //向微信注册
    [WXApi registerApp:@"wxe2f3ac8b56d2c16a"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

// 逗比啊啊啊啊啊
#pragma mark - 微信回调
-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (resp.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"call_back" object:@"分享成功"];
        } else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"call_back" object:@"分享失败"];
        }
    } else {
        NSLog(@"什么类型%@", [resp class]);
    }
}


@end
