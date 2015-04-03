//
//  ShareDisplayView.m
//  myWallpaper
//
//  Created by wangzijie on 15/2/3.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "ShareDisplayView.h"
#import "AppDelegate.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "UIImageView+WebCache.h"

#define ShareButtonDistanceToCenter 220
#define ShareIconSize 50

@implementation ShareDisplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setShareInfo];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    self.mainBackgroundView.hidden = YES;
    NSLog(@"dianji ");
}

-(void)setShareInfo
{
    BetweenShareIconDistance=CGRectGetWidth(self.bounds)/8;
    UIVisualEffectView *shareBackgroundImageView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    shareBackgroundImageView.frame = self.bounds;
    [self addSubview:shareBackgroundImageView];
    _mainBackgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    //返回按钮
    UIButton *backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backButton addTarget:self action:@selector(removeShareView) forControlEvents:UIControlEventTouchUpInside];
    [_mainBackgroundView addSubview:backButton];
    
    UIButton *weixin = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-3*ShareIconSize-2*BetweenShareIconDistance)/2, 120, ShareIconSize, ShareIconSize)];
    [weixin setBackgroundImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateNormal];
    weixin.tag=101;
    [weixin addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pyq = [[UIButton alloc]initWithFrame:CGRectMake(weixin.frame.origin.x+BetweenShareIconDistance+ShareIconSize, 120, ShareIconSize, ShareIconSize)];
    [pyq setBackgroundImage:[UIImage imageNamed:@"share_circle"] forState:UIControlStateNormal];
    pyq.tag=102;
    [pyq addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *weibo = [[UIButton alloc]initWithFrame:CGRectMake(pyq.frame.origin.x+BetweenShareIconDistance+ShareIconSize, 120, ShareIconSize, ShareIconSize)];
    [weibo setBackgroundImage:[UIImage imageNamed:@"share_weibo"] forState:UIControlStateNormal];
    weibo.tag=103;
    [weibo addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    weixin.alpha=0;
    //    pyq.alpha=0;
    //    weibo.alpha=0;
    
    [_mainBackgroundView addSubview:weixin];
    [_mainBackgroundView addSubview:pyq];
    [_mainBackgroundView addSubview:weibo];
    
    [self addSubview:_mainBackgroundView];
    //    [UIView animateWithDuration:0.3 animations:^{
    //        weibo.alpha=1;
    //        pyq.alpha=1;
    //        weixin.alpha=1;
    //    }];
}

-(void)receiveShareImage:(NSString *)imageStr
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    shareImage = imageView.image;
}

- (void)shareButton:(UIButton *)button
{
    [self removeShareView];
    if (button.tag == 101) {
        NSString *schemeURL = @"weixin://";
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:schemeURL]]) {
            [self sendImageContentToSession:@"Wa" withImage:shareImage];
        } else {
            // 提示未安装微信客户端
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未安装微信客户端,请先安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (button.tag == 102) {
        if ([WXApi isWXAppInstalled]) {
            [self sendImageContentToTimeLine:@"Wa" withImage:shareImage];
        } else {
            // 提示未安装微信客户端
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未安装微信客户端,请先安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (button.tag == 103) {
        // 微博分享
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未安装微博客户端,请先安装微博客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)sendImageContentToSession:(NSString *)text withImage:(UIImage *)imageUrl
{

    WXMediaMessage* messageObj = [WXMediaMessage message];
    messageObj.title = @"Wa---艺术就是这么简单";
    messageObj.description = @"我在<<Wa>>这个应用中发现一位艺术家的作品非常吸引我, 分享给你, 如果喜欢, 你也可以来这里......";
    [messageObj setThumbData:UIImageJPEGRepresentation(imageUrl,0.5)];  // 图片大小不能超过32K 之前因为图片大小分享总是不跳转微信客户端
    WXAppExtendObject* ext = [WXAppExtendObject object];
   //  点击图片跳转的网页
    ext.url =  @"https://www.baidu.com";
    messageObj.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = messageObj;
    req.scene = 0;
    [WXApi sendReq:req];

}

- (void)sendImageContentToTimeLine:(NSString *)text withImage:(UIImage *)imageUrl
{
    WXMediaMessage* messageObj = [WXMediaMessage message];
    messageObj.title = @"Wa---艺术就是这么简单";
    messageObj.description = @"我在<<Wa>>这个应用中发现一位艺术家的作品非常吸引我, 分享给你, 如果喜欢, 你也可以来这里......";
    [messageObj setThumbData:UIImageJPEGRepresentation(imageUrl,0.5)];  // 图片大小不能超过32K 之前因为图片大小分享总是不跳转微信客户端
    WXAppExtendObject* ext = [WXAppExtendObject object];
    //  点击图片跳转的网页
    ext.url =  @"https://www.baidu.com";
    messageObj.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = messageObj;
    req.scene = 1;
    [WXApi sendReq:req];
}

-(void)removeShareView//移除view
{
    if ([_delegate respondsToSelector:@selector(removeShareView)])
    {
        [_delegate removeShareView];
    }
}


@end
