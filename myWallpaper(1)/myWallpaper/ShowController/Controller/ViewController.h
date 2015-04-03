//
//  ViewController.h
//  myWallpaper
//
//  Created by wangzijie on 15/1/28.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperCell.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
#import "List.h"
#import "BigImageView.h"
#import "ShareDisplayView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
//#import <AssetsLibrary/AssetsLibrary.h>
@interface ViewController : UIViewController<shareViewDelegate, BigImageViewDelegate>
{
    ShareDisplayView *shareView;
    BigImageView *bigImageVIew;
}

@property (nonatomic, strong)List *list;

//@property (nonatomic, strong)ShareDisplayView *shareView;




@end

