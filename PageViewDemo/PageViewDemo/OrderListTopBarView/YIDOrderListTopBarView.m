//
//  YIDOrderListTopBarView.m
//  OneCarDriver
//
//  Created by zhouwei on 2018/7/26.
//  Copyright © 2018年 yirenyiche. All rights reserved.
//

#import "YIDOrderListTopBarView.h"
#import "YIDOrderListTopBarCell.h"

@interface YIDOrderListTopBarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *lineView; //下方的线
@property (nonatomic, assign) NSInteger changeIndex; //

@end

@implementation YIDOrderListTopBarView

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count{
    self = [super initWithFrame:frame];
    if(self){
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(self.frame.size.width/count, self.frame.size.height);
        layout.minimumLineSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.scrollEnabled = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:NSClassFromString(@"YIDOrderListTopBarCell")
                forCellWithReuseIdentifier:YICOrderTopBarCellIdentifier];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = HexColor(@"FF8207");

        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.lineView];
        
        [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        CGFloat itemWidth = self.frame.size.width/count;
        self.lineView.frame = CGRectMake(itemWidth/2 - 14, 33, 28, 2);
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleNameAry.count;
}

NSString * const YICOrderTopBarCellIdentifier = @"YICOrderListTopButtonCell";
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIDOrderListTopBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YICOrderTopBarCellIdentifier forIndexPath:indexPath];
    [cell reloadDataTopButtonWithTitle:[self.titleNameAry objectAtIndex:indexPath.row] indexPath:indexPath changeIndex:self.changeIndex];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    if(selectIndex >= self.titleNameAry.count || selectIndex < 0){
        return;
    }
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
    [self.collectionView selectItemAtIndexPath:selectIndexPath
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    self.changeIndex = selectIndex;
    [self.collectionView reloadData];
    if(self.clickTouch){
        self.clickTouch(selectIndex);
        [self updateBottomLineLayoutWithIndex:selectIndex];
    }
}

- (void)updateBottomLineLayoutWithIndex:(NSInteger)index{
    CGFloat itemWidth = self.frame.size.width/self.titleNameAry.count;
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.center = CGPointMake(itemWidth * index + itemWidth/2, 33);
    }];
}

@end
