//
//  ViewController.m
//  myWallpaper
//
//  Created by wangzijie on 15/1/28.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)UICollectionView *superCollectionView;

@property (nonatomic, strong)NSMutableArray *imageArr;

@property (nonatomic, strong)UILabel *pageNo;

@property (nonatomic, strong)UIButton *listButton;

@property (nonatomic, strong)UIButton *functionButton;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.imageArr = [NSMutableArray array];
        self.list = [[List alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"传值" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBigImageView:) name:@"显示或隐藏全屏视图" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backChangePage:) name:@"返回改变页码" object:nil];
    }
    return self;
}


// 消息中心的响应方法
- (void)receiveNotification:(NSNotification *)noti
{
    [self.imageArr removeAllObjects];
    self.list.listId = noti.object;
    [self reloadata];
}

// 显示全屏图片执行的方法
- (void)showBigImageView:(NSNotification *)noti
{
    NSString *markCell = [NSString stringWithFormat:@"%@", noti.object];
    bigImageVIew.bigCollectionView.contentOffset = CGPointMake(SCREEN_WIDTH *[markCell intValue], 0);
    bigImageVIew.delegate = self;
    bigImageVIew.hidden = NO;
    self.listButton.hidden = YES;
    self.functionButton.hidden = YES;
    self.pageNo.hidden = YES;
    
}

// 返回9宫格执行的方法
- (void)backChangePage:(NSNotification *)noti
{
    int page = [noti.object intValue] / 9;
    self.superCollectionView.contentOffset = CGPointMake(SCREEN_WIDTH * page, 0);
    bigImageVIew.hidden = YES;
    self.listButton.hidden = NO;
    self.functionButton.hidden = NO;
    self.pageNo.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.list.listId = @"8";
    [self setupViews];
    [self reloadata];
    // Do any additional setup after loading the view, typically from a nib.
}

// 创建列表的按钮
- (void)setListButton
{
    self.listButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.listButton.frame = CGRectMake(15, 20, 30, 30);
    [self.listButton setImage:[UIImage imageNamed:@"list.png"] forState:UIControlStateNormal];
    self.listButton.tintColor = [UIColor grayColor];
    [self.listButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.listButton];
}

// 创建功能按钮
- (void)setFunctionButton
{
    self.functionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.functionButton.frame = CGRectMake(SCREEN_WIDTH - 15 - 30, 20, 30, 30);
    [self.functionButton setImage:[UIImage imageNamed:@"function.png"] forState:UIControlStateNormal];
    self.functionButton.tintColor = [UIColor grayColor];
    [self.functionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.functionButton];
}

-(void)setPageNo
{
    self.pageNo = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, SCREEN_HEIGHT - 40, 50, 30)];
    self.pageNo.backgroundColor = [UIColor clearColor];
    self.pageNo.textColor = [UIColor grayColor];
    self.pageNo.textAlignment = 1;
    self.pageNo.text = @"1";
    [self.view addSubview:self.pageNo];
}


// 加载视图
- (void)setupViews
{
    UICollectionViewFlowLayout *superLayout = [[UICollectionViewFlowLayout alloc] init];
    superLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 40);
    superLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    superLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    superLayout.minimumLineSpacing = 0;
    self.superCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 30 - 20) collectionViewLayout:superLayout];
    self.superCollectionView.pagingEnabled = YES;
    self.superCollectionView.delegate = self;
    self.superCollectionView.dataSource = self;
    self.superCollectionView.bounces = NO;
    self.superCollectionView.showsHorizontalScrollIndicator = NO;
    self.superCollectionView.backgroundColor = [UIColor whiteColor];
    [self.superCollectionView registerClass:[SuperCell class] forCellWithReuseIdentifier:@"superCell"];
    [self.view addSubview:self.superCollectionView];
    
    // 创建全屏显示视图
    bigImageVIew = [[BigImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:bigImageVIew];
    bigImageVIew.hidden = YES;
    
    [self setPageNo];
    [self setListButton];
    [self setFunctionButton];
}

// 加载数据
- (void)reloadata
{
    MBProgressHUD *hub = [[MBProgressHUD alloc] init];
    [hub setMode:MBProgressHUDModeDeterminate];
    [self.view addSubview:hub];
    [hub show:YES];
    NSDictionary *dic = @{@"a":@"category", @"tid":self.list.listId, @"device":@"", @"uuid":@"35645E528C0A43B0A491FD1E15334A70", @"mode":@"0", @"retina": @"0", @"client_id":@"1002", @"device_id":@"47927802", @"model_id":@"100", @"size_id":@"0", @"channel_id":@"19960", @"screen_width":@"750", @"screen_height":@"1334", @"bizhi_width":@"1080", @"bizhi_height":@"1920", @"version_code":@"47", @"language":@"zh-Hans", @"jailbreak":@"0", @"mac":@"299CCE9F-B64A-4AAA-8A48-53D1824C4817", @"order":@"newest", @"color_id":@"3"};
    NSString *url = @"http://api.lovebizhi.com/iphone_v3.php?";
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    [manager1.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    [manager1 GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //self.imageArr = [NSMutableArray array];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            NSDictionary *image = dic[@"image"];
            NSString *small = image[@"small"];
            NSString *imageStr = [small stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
           // NSLog(@"%@", imageStr);
            [self.imageArr addObject:imageStr];
        }
        [self.superCollectionView reloadData];
        // 每一次网络解析后返回第一页
        self.superCollectionView.contentOffset = CGPointMake(0, 0);
        // 解析后将数组传到全屏视图页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"传歌曲数组" object:self.imageArr];
        [hub removeFromSuperview];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [hub removeFromSuperview];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载失败" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
        self.pageNo.hidden = YES;
        self.listButton.hidden = YES;
        self.functionButton.hidden = YES;
    }];

}

// collectionView的相关方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"%u", self.imageArr.count / 9);
    return self.imageArr.count / 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SuperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"superCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    //NSLog(@"%ldlllllll", (long)indexPath.row);
    cell.imageArr = self.imageArr;
    cell.mark = (int)indexPath.row;
    [cell.subCollectionView reloadData];
    return cell;
}


// 页码计算的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.superCollectionView) {
        float a = self.superCollectionView.contentOffset.x / self.view.bounds.size.width + 1;
        NSString *str1 = [NSString stringWithFormat:@"%.f", a];
        self.pageNo.text = str1;
    }
}

// 列表按钮的点击方法
- (void)buttonAction:(UIButton *)button
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YRSideViewController *sideViewController = [delegate sideViewController];
    if (button == self.listButton) {
        [sideViewController showLeftViewController:true];
    } else if (button == self.functionButton) {
        [sideViewController showRightViewController:true];
    }
}

//添加分享页面
-(void)share:(NSString *)imageStr
{
    if (!shareView) {
        [UIView animateWithDuration:0.2 animations:^{shareView.alpha=0.0;}
                         completion:^(BOOL finished) {
                             shareView=[[ShareDisplayView alloc]initWithFrame:self.view.bounds];
                             shareView.delegate=self;
                             [self.view addSubview:shareView];
                             [shareView receiveShareImage:imageStr];
                         }];
    }
}

-(void)removeShareView // 移除分享页面
{
    if (shareView) {
        [UIView animateWithDuration:0.2 animations:^{shareView.alpha=0.0;}
                         completion:^(BOOL finished) {
                             [shareView removeFromSuperview];
                             shareView=nil;
                         }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
