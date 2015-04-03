//
//  BigImageView.h
//  myWallpaper
//
//  Created by 王子洁 on 15/2/1.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BigImageViewDelegate <NSObject>

-(void)share:(NSString *)imageStr;

@end

@interface BigImageView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
{
    NSInteger whichCell;
    
}
@property (nonatomic, strong) NSMutableArray *bigImageArr;

@property (nonatomic, assign) int mark;

@property (nonatomic, strong) UICollectionView *bigCollectionView;

@property (nonatomic, assign) id <BigImageViewDelegate>delegate;
@end
