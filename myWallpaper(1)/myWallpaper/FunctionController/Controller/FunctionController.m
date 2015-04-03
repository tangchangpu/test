//
//  FunctionController.m
//  myWallpaper
//
//  Created by wangzijie on 15/1/30.
//  Copyright (c) 2015年 王子洁. All rights reserved.
//

#import "FunctionController.h"

@interface FunctionController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *functionTableView;

@property (nonatomic, strong)NSArray *functionArr;

@end

@implementation FunctionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.functionArr = [NSMutableArray arrayWithObjects:@"登陆", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

// 设置视图
- (void)setupView
{
    self.functionTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - IMAGE_WIDTH, 40, IMAGE_WIDTH, SCREEN_HEIGHT - 40 - 30) style:UITableViewStyleGrouped];
    self.functionTableView.delegate = self;
    self.functionTableView.dataSource = self;
    self.functionTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.functionTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.functionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    cell.textLabel.text = self.functionArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
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
