//
//  ViewController.m
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ViewController.h"
#import "HHDoubleVideotapePageView.h"
#import "HHPageViewModel.h"
#import "HHPageViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HHDoubleVideotapePageView *itemView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.data=[NSMutableArray new];
    
    //set tab data
    [self initData];
    
    UIColor *lineColor=[UIColor colorWithRed:31/255.0 green:195/255.0 blue:249/255.0 alpha:1.0];
//    self.itemView = [[HHDoubleVideotapePageView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)count:self.data.count left:10.0f midSpaceSize:30.0f cellWidth:100.0f lineWidth:40 lineHigth:6 lineColor:lineColor];
    self.itemView = [[HHDoubleVideotapePageView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)count:self.data.count lineWidth:40 lineHigth:6 lineColor:lineColor];
    self.itemView.defultFontSize = 14;
    self.itemView.selectedFontSize = 20;
    self.itemView.defultFontColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.itemView.selectedFontColor=[UIColor colorWithRed:31/255.0 green:195/255.0 blue:249/255.0 alpha:1.0];
    self.itemView.defultFontFimaly=@"SnellRoundhand";
    self.itemView.selectedFontFimaly=@"SnellRoundhand-Bold";
    self.itemView.showMidLine=YES;
    self.itemView.items = self.data;
    [self.view addSubview:self.itemView];
    [self.itemView reloadCollectionData];
    
    UIView *grayLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 1)];
    [self.view addSubview:grayLineView];
    grayLineView.backgroundColor=[UIColor grayColor];
    
    
    
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 101, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-101)];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.scrollView];
    
    
    __weak typeof(self) weakSelf = self;
    self.itemView.selectBlock = ^(NSUInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
//        NSLog(@"---%@----",@(index));
        [UIView animateWithDuration:0.4 animations:^{
            [strongSelf.scrollView setContentOffset:CGPointMake(strongSelf.scrollView.bounds.size.width * index, 0)];
        }];
    };
    self.itemView.selectIndex = 0;
    
    for (NSInteger i = 0; i < self.data.count; i ++) {
        HHPageViewController *page = [HHPageViewController new];
        page.view.frame = CGRectMake(self.scrollView.bounds.size.width * i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        page.strTitle = [NSString stringWithFormat:@"%@",@(i+1)];
        [self.scrollView addSubview:page.view];
        [self addChildViewController:page];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * self.data.count, self.scrollView.bounds.size.height);
    
}

- (void)initData {
    HHPageViewModel *model2 = [HHPageViewModel new];
    model2.count = @(0);
    model2.title = @"First";
    HHPageViewModel *model3 = [HHPageViewModel new];
    model3.count = @(1);  
    model3.title = @"Second";
    HHPageViewModel *model4 = [HHPageViewModel new];
    model4.count = @(1);
    model4.title = @"Third";
    
    [self.data addObject:model2];
    [self.data addObject:model3];
    [self.data addObject:model4];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.itemView.selectIndex = index;
}


@end
