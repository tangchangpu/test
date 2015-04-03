//
//  ListController.m
//  myWallpaper
//
//  Created by wangzijie on 15/1/30.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "ListController.h"

@interface ListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *listArr;  //记录列表内都有什么内容

@property (nonatomic, strong)UITableView *listTableView;  //列表

@end

@implementation ListController
/*
 体育运动  tid = 1554
 美丽文字 tid = 21866
 品牌欣赏 tid = 10
 炫彩美图 tid = 1920
 动物宠物 tid = 5
 花卉植物 tid = 4
 风光风景 tid = 2
 美图杂烩 tid = 2097
 艺术设计 tid = 1407
 节庆假日 tid = 8
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.listArr = [NSMutableArray array];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self reloadata];
}

// 创建视图
- (void)setupView
{
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, IMAGE_WIDTH, SCREEN_HEIGHT - 40 - 30) style:UITableViewStyleGrouped];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listTableView];
}

// 加载数据
- (void)reloadata
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"local" ofType:@"txt"];
    NSString *fileString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [fileString componentsSeparatedByString:@"\n"];
    for (NSString *str in lines) {
        NSArray *tempArr = [str componentsSeparatedByString:@","];
        List *list = [[List alloc] init];
        list.listId = tempArr[0];
        list.listTitle = tempArr[1];
        [self.listArr addObject:list];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    List *list = self.listArr[indexPath.row];
    cell.textLabel.text = list.listTitle;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    List *list = self.listArr[indexPath.row];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YRSideViewController *sideViewController = [delegate sideViewController];
    [sideViewController hideSideViewController:true];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"传值" object:list.listId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
