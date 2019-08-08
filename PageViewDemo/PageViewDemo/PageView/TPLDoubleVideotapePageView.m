//
//  TPLDoubleVideotapePageView.m
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TPLDoubleVideotapePageView.h"
#import "TPLPageCollectionViewCell.h"
#import "TPLPageViewModel.h"
// Pods
#import <Masonry/Masonry.h>

@interface TPLDoubleVideotapePageView ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) NSInteger changeIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
//cell间隔距离
@property (nonatomic, assign) CGFloat midSpace;
//cell宽
@property (nonatomic, assign) CGFloat itemWidth;

//设置滚动条size 
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineHigth;
@end
@implementation TPLDoubleVideotapePageView

static NSString * const ID = @"TPLPageCollectionViewCell";

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count left:(CGFloat)left midSpaceSize:(CGFloat)midSpaceSize cellWidth:(CGFloat)cellWidth lineWidth:(CGFloat)lineWidth lineHigth:(CGFloat)lineHigth lineColor:(UIColor *)lineColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.showMidLine=YES;
        self.lineWidth=lineWidth;
        self.lineHigth=lineHigth;
        self.midSpace=midSpaceSize;
        self.itemWidth=0.0f;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        if (cellWidth>0) {
            self.itemWidth = cellWidth;
        } else {
            self.itemWidth = self.frame.size.width/count;
        }
        layout.itemSize = CGSizeMake(self.itemWidth, self.frame.size.height);
        layout.minimumLineSpacing = midSpaceSize;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.scrollEnabled = YES;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[TPLPageCollectionViewCell class] forCellWithReuseIdentifier:ID];
        
        self.lineView = [UIView new];
        self.lineView.layer.backgroundColor = lineColor.CGColor;
        self.lineView.layer.cornerRadius = 3;
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.lineView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).mas_offset(UIEdgeInsetsMake(0, left, 0, 0));
        }];
        [self.collectionView layoutIfNeeded];
        self.lineView.frame = CGRectMake(self.itemWidth/2-self.lineWidth/2 , self.collectionView.bounds.size.height - self.lineHigth, self.lineWidth, self.lineHigth);
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count lineWidth:(CGFloat)lineWidth lineHigth:(CGFloat)lineHigth lineColor:(UIColor *)lineColor{
    self = [self initWithFrame:frame count:count left:0 midSpaceSize:0 cellWidth:0 lineWidth:lineWidth lineHigth:lineHigth lineColor:lineColor];
    if (self) {
        
    }
    return self;
}

- (void)reloadCollectionData {
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPLPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.defultFontSize = self.defultFontSize;
    cell.defultFontColor=self.defultFontColor;
    cell.defultFontFimaly=self.defultFontFimaly;
    cell.selectedFontSize = self.selectedFontSize;
    cell.selectedFontColor=self.selectedFontColor;
    cell.selectedFontFimaly=self.selectedFontFimaly;
    
    if (indexPath.row == self.items.count- 1 || !self.showMidLine) {
        cell.midLine.hidden = YES;
    }else{
        cell.midLine.hidden = NO;
    }
    
    [cell reloadDataTopButtonWithTitle:[self.items objectAtIndex:indexPath.row] indexPath:indexPath changeIndex:self.changeIndex];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击item
    self.selectIndex = indexPath.row;
}

- (void)setSelectIndex:(NSUInteger)selectIndex{
    if(selectIndex >= self.items.count || selectIndex < 0 || self.changeIndex == selectIndex){
        return;
    }
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:self.changeIndex inSection:0];
    [self.collectionView selectItemAtIndexPath:selectIndexPath
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    self.changeIndex = selectIndex;
    TPLPageViewModel *model = [self.items objectAtIndex:self.changeIndex];
    model.count=@(0);
    
    [self.collectionView reloadData];
    if(self.selectBlock){
        self.selectBlock(selectIndex);
        [self updateBottomLineLayoutWithIndex:selectIndex];
    }
}
static NSUInteger _defultFontSize;
- (void)setDefultFontSize:(NSUInteger)defultFontSize {
    _defultFontSize = defultFontSize;
}
- (NSUInteger)defultFontSize {
    if(_defultFontSize == 0) {
        return 14;
    } else {
        return _defultFontSize;
    }
}
static UIColor *_defultFontColor;
- (void)setDefultFontColor:(UIColor *)defultFontColor {
    _defultFontColor = defultFontColor;
}
- (UIColor *)defultFontColor {
    if (_defultFontColor == nil) {
        return [UIColor blackColor];
    } else {
        return _defultFontColor;
    }
}

static NSString *_defaultFontFimaly;
- (void)setDefultFontFimaly:(NSString *)defultFontFimaly {
    defultFontFimaly = [self getUIFontWithFimalyName:defultFontFimaly];
    _defaultFontFimaly = defultFontFimaly;
}
- (NSString *)defultFontFimaly {
    if (_defaultFontFimaly == nil) {
        return @"nil";
    } else {
        return _defaultFontFimaly;
    }
}

static NSUInteger _seletedFontSize;
- (void)setSelectedFontSize:(NSUInteger)selectedFontSize {
    _seletedFontSize = selectedFontSize;
}
- (NSUInteger)selectedFontSize{
    if(_seletedFontSize == 0) {
        return 14;
    } else {
        return _seletedFontSize;
    }
}

static UIColor *_selectedFontColor;
- (void)setSelectedFontColor:(UIColor *)selectedFontColor {
    _selectedFontColor = selectedFontColor;
}
- (UIColor *)selectedFontColor {
    if (_selectedFontColor == nil) {
        return [UIColor blackColor];
    } else {
        return _selectedFontColor;
    }
}

static NSString *_selectedFontFimaly;
- (void)setSelectedFontFimaly:(NSString *)selectedFontFimaly {
    selectedFontFimaly = [self getUIFontWithFimalyName:selectedFontFimaly];
    _selectedFontFimaly = selectedFontFimaly;
}
- (NSString *)selectedFontFimaly {
    if (_selectedFontFimaly == nil) {
        return @"nil";
    } else {
        return _selectedFontFimaly;
    }
}

static BOOL _showMidLine;
- (void)setShowMidLine:(BOOL)showMidLine {
    _showMidLine =showMidLine;
}
- (BOOL)showMidLine {
    return _showMidLine;
}

- (void)updateBottomLineLayoutWithIndex:(NSInteger)index{
    CGFloat itemWidthAll = self.itemWidth + self.midSpace;
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.frame = CGRectMake(itemWidthAll * index + self.itemWidth/2-self.lineWidth/2 , self.collectionView.bounds.size.height - self.lineHigth, self.lineWidth, self.lineHigth);
    }];
}

- (NSString *)getUIFontWithFimalyName:(NSString *)name {
    if (name == nil) {
        return @"nil";
    } else {
        NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
        for(NSString *familyName in familyNames)
        {
            NSArray *fontNames =[UIFont fontNamesForFamilyName:familyName];
            for(NSString *fontName in fontNames)
            {
                NSLog(@"%@",fontName);
                if ([fontName isEqualToString:name]) {
                    return fontName;
                }
            }
        }
        return @"nil";
    }
    
}
@end
