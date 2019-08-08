//
//  YIDOrderListTopBarCell.m
//  OneCarDriver
//
//  Created by zhouwei on 2018/7/26.
//  Copyright © 2018年 yirenyiche. All rights reserved.
//

#import "YIDOrderListTopBarCell.h"

@interface YIDOrderListTopBarCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YIDOrderListTopBarCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = HexColor(@"989898");
        [self addSubview:self.titleLabel];

        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)reloadDataTopButtonWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath changeIndex:(NSInteger)changeindex{
    self.titleLabel.text = title;
    if (indexPath.row == changeindex) {
        self.titleLabel.textColor = HexColor(@"FF8207");
    }else{
        self.titleLabel.textColor = HexColor(@"989898");
    }
}

@end
