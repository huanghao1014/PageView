//
//  YIDOrderListTopBarView.h
//  OneCarDriver
//
//  Created by zhouwei on 2018/7/26.
//  Copyright © 2018年 yirenyiche. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickTouch)(NSInteger index);

@interface YIDOrderListTopBarView : UIView

@property (nonatomic, copy  ) ClickTouch clickTouch;
@property (nonatomic, strong) NSMutableArray *titleNameAry;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;

@end
