//
//  TPLPageViewController.m
//  PageViewDemo
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HHPageViewController.h"

@interface HHPageViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation HHPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [self.view addSubview:self.label];
   
}
-(void)viewDidAppear:(BOOL)animated {
    self.label.text=[NSString stringWithFormat:@"当前是第%@页！",self.strTitle];
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
