//
//  TPLPageCollectionViewCell.m
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HHPageCollectionViewCell.h"
#import "UILabel+Badge.h"
// Pods
#import <Masonry/Masonry.h>

@interface HHPageCollectionViewCell()
{
    
}
@end
@implementation HHPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemLabel = [UILabel new];
        self.itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.itemLabel];
        
        self.midLine = [UIView new];
        self.midLine.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:self.midLine];
        //layout
        [self layoutIfNeeded];
        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.itemLabel.mas_centerY);
            make.centerX.mas_equalTo(self.itemLabel.mas_right);
            make.height.mas_equalTo(self.itemLabel.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(@(1));
        }];
    }
    return self;
}

- (void)reloadDataTopButtonWithTitle:(HHPageViewModel *)model indexPath:(NSIndexPath *)indexPath changeIndex:(NSInteger)changeindex{
    //显示tab名
    self.itemLabel.text = model.title;
    //redCount 大于0 显示小红点
    if (indexPath.row == changeindex) {
        if(![self.selectedFontFimaly isEqualToString:@"nil"]) {
            self.itemLabel.font = [UIFont fontWithName:self.selectedFontFimaly size:self.selectedFontSize];
        } else {
            self.itemLabel.font = [UIFont boldSystemFontOfSize:self.selectedFontSize];
        }
        self.itemLabel.textColor = self.selectedFontColor;
    } else{
        if(![self.selectedFontFimaly isEqualToString:@"nil"]) {
            self.itemLabel.font = [UIFont fontWithName:self.defultFontFimaly size:self.defultFontSize];
        } else {
            self.itemLabel.font = [UIFont systemFontOfSize:self.defultFontSize];
        }
        self.itemLabel.textColor = self.defultFontColor;
    }
    self.itemLabel.redCount = model.count;
    
}
@end
