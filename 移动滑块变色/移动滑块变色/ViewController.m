//
//  ViewController.m
//  移动滑块变色
//
//  Created by 施永辉 on 16/8/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "YHChangeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titleArr= @[@"第一个",@"第二个",@"第三个",@"第四个",@"第五个",@"第六个"];
    YHChangeView * changeView = [[YHChangeView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andTitleArr:titleArr];
    changeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:changeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
