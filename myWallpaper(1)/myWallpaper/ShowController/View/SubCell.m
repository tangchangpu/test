//
//  SubCell.m
//  myWallpaper
//
//  Created by wangzijie on 15/1/29.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "SubCell.h"

@implementation SubCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.myImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myImageView.frame = self.contentView.frame;

    //self.myImageView.backgroundColor = [UIColor greenColor];
    
}






@end
