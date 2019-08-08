//
//  TPLPageCollectionViewCell.h
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HHPageViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHPageCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UIView *midLine;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSString *defultFontFimaly;
@property (nonatomic, strong) UIColor *defultFontColor;
@property (nonatomic, assign) NSUInteger defultFontSize;

@property (nonatomic, strong) NSString *selectedFontFimaly;
@property (nonatomic, strong) UIColor *selectedFontColor;
@property (nonatomic, assign) NSUInteger selectedFontSize;


- (void)reloadDataTopButtonWithTitle:(HHPageViewModel *)title indexPath:(NSIndexPath *)indexPath changeIndex:(NSInteger)changeindex;

@end

NS_ASSUME_NONNULL_END
