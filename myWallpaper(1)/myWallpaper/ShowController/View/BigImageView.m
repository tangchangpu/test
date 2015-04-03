//
//  BigImageView.m
//  myWallpaper
//
//  Created by 王子洁 on 15/2/1.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "BigImageView.h"
#import "SubCell.h"
#import "UIImageView+WebCache.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation BigImageView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bigImageArr = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveImageArr:) name:@"传歌曲数组" object:nil];
        [self commonInit];
    }
    return self;
}

- (void)receiveImageArr:(NSNotification *)noti
{
    //[self.bigImageArr removeAllObjects];
    self.bigImageArr = noti.object;
    [self.bigCollectionView reloadData];
}

-(void)commonInit
{
    UICollectionViewFlowLayout *superLayout = [[UICollectionViewFlowLayout alloc] init];
    superLayout.itemSize = CGSizeMake(self.frame.size.width , self.frame.size.height);
    superLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    superLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    superLayout.minimumLineSpacing = 0;
    self.bigCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:superLayout];
    self.bigCollectionView.pagingEnabled = YES;
    self.bigCollectionView.delegate = self;
    self.bigCollectionView.dataSource = self;
    self.bigCollectionView.showsHorizontalScrollIndicator = NO;
    self.bigCollectionView.backgroundColor = [UIColor yellowColor];
    self.bigCollectionView.bounces = NO;
    [self.bigCollectionView registerClass:[SubCell class] forCellWithReuseIdentifier:@"bigCell"];
    [self addSubview:self.bigCollectionView];
    
    // 给全屏视图添加下滑手势
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeAction:)];
    downSwipe.numberOfTouchesRequired = 1;
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:downSwipe];
    
    // 给全屏视图添加上滑手势
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeAction:)];
    upSwipe.numberOfTouchesRequired = 1;
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:upSwipe];

}


#pragma mark - UICollectionView 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bigImageArr.count / 9 * 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bigCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    cell.myImageView.backgroundColor = [UIColor greenColor];
    NSString *image = self.bigImageArr[indexPath.row];
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"diepian.jpg"]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"mmmmm点击");
    NSString *str = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"返回改变页码" object:str];
}

// 页码计算的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.bigCollectionView) {
        float a = self.bigCollectionView.contentOffset.x / self.bounds.size.width;
        whichCell = (NSInteger)a;
    }
    
}

- (void)upSwipeAction:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"上滑");
    //    self.shareDisplayView.hidden = NO;
    if ([_delegate respondsToSelector:@selector(share:)]){
        [_delegate share:self.bigImageArr[whichCell]];
    }
}

- (void)downSwipeAction:(UISwipeGestureRecognizer *)swipe
{
    NSString *str = self.bigImageArr[whichCell];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(imageSaveToPhotosAlbum:didFishSavingWithError:contentInfo:), nil);
}

- (void)imageSaveToPhotosAlbum:(UIImage *)image didFishSavingWithError:(NSError *)error contentInfo:(void *)contextInfo
{
    // 获取能否访问相册的权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusAuthorized) {
        // 禁用全屏视图的用户交互
        self.userInteractionEnabled = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 120) / 2, self.frame.size.height - 80, 120, 30)];
        label.backgroundColor = [UIColor blackColor];
        label.layer.cornerRadius = 10;
        label.clipsToBounds = YES;
        label.alpha = 0.7;
        label.text = @"已下载";
        label.textAlignment = 1;
        label.font = [UIFont systemFontOfSize:15];
        label.tag = 1100;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        NSTimer *timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(doTimer) userInfo:nil repeats:NO];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载失败" message:@"请前往设置修改权限" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

// 时间器执行的方法
- (void)doTimer
{
    UILabel *label = (UILabel*)[self viewWithTag:1100];
    [label removeFromSuperview];
    // 恢复全屏视图的用户交互
    self.userInteractionEnabled = YES;
}

@end
