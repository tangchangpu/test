//
//  SuperCell.h
//  myWallpaper
//
//  Created by 王子洁 on 15/1/28.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "BigImageView.h"
@interface SuperCell : UICollectionViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *subCollectionView; // 每一页滚动的是一个CollecionView的Cell cell中是subCollectionView
@property (nonatomic, strong)NSMutableArray *imageArr; // 图片数组

@property (nonatomic, assign)int mark; // 记录是第几页

@property (nonatomic, strong)NSString *markCell; // 记录是哪个cell

@end
