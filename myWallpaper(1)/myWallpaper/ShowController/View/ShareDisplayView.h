//
//  ShareDisplayView.h
//  myWallpaper
//
//  Created by wangzijie on 15/2/3.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shareViewDelegate<NSObject>
-(void)removeShareView;
@end


@interface ShareDisplayView : UIView
{
        CGFloat BetweenShareIconDistance;
//        NSDictionary *songsDic;
        UIImage *shareImage;
}
@property(weak,nonatomic)id<shareViewDelegate> delegate;// 声明委托

@property(nonatomic,strong)UIView *mainBackgroundView;

-(void)setShareInfo;

-(void)receiveShareImage:(NSString *)imageStr;


@end
