//
//  SuperCell.m
//  myWallpaper
//
//  Created by 王子洁 on 15/1/28.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "SuperCell.h"

@implementation SuperCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.subCollectionView = [[UICollectionView alloc] init];
//        [self.contentView addSubview:self.subCollectionView];
        self.imageArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupViews];
}

- (void)setupViews
{
    UICollectionViewFlowLayout *superLayout = [[UICollectionViewFlowLayout alloc] init];
    superLayout.itemSize = CGSizeMake((self.contentView.frame.size.width - 50) / 3, (self.contentView.frame.size.height - 40) / 3);
//    (self.contentView.frame.size.height - 60 - 30 - 20 - 20) / 3
    //superLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    superLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    superLayout.minimumLineSpacing = 10;
    self.subCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) collectionViewLayout:superLayout];
   // NSLog(@"%f", self.contentView.frame.size.height - 60 - 30 - 20);
    self.subCollectionView.pagingEnabled = YES;
    self.subCollectionView.delegate = self;
    self.subCollectionView.dataSource = self;
    self.subCollectionView.showsHorizontalScrollIndicator = NO;
    self.subCollectionView.backgroundColor = [UIColor whiteColor];
    [self.subCollectionView registerClass:[SubCell class] forCellWithReuseIdentifier:@"subCell"];
    [self.contentView addSubview:self.subCollectionView];

}


#pragma mark - UICollectionView 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    cell.myImageView.backgroundColor = [UIColor grayColor];
    NSString *image = self.imageArr[indexPath.item + self.mark * 9];
     [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"diepian.jpg"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"<<<<<点击cell");
    int whichCell = (int)indexPath.item + self.mark * 9;
    self.markCell = [NSString stringWithFormat:@"%d", whichCell];
    NSLog(@"*********%d", [self.markCell intValue]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"显示或隐藏全屏视图" object:self.markCell];
}



@end
