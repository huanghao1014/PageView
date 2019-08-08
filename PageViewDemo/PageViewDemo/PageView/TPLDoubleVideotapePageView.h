//
//  TPLDoubleVideotapePageView.h
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TPLTabBarBlock)(NSUInteger index);

@interface TPLDoubleVideotapePageView : UIView

@property (nonatomic, copy) TPLTabBarBlock selectBlock;

//选中位置
@property (nonatomic, assign) NSUInteger selectIndex;

//设置选项卡名称和是否显示红点
@property (nonatomic, strong) NSMutableArray *items;

//设置默认 label样式
@property (nonatomic, strong) NSString *defultFontFimaly;
@property (nonatomic, strong) UIColor *defultFontColor;
@property (nonatomic, assign) NSUInteger defultFontSize;
//设置选中 label样式
@property (nonatomic, strong) NSString *selectedFontFimaly;
@property (nonatomic, strong) UIColor *selectedFontColor;
@property (nonatomic, assign) NSUInteger selectedFontSize;

//设置是否显示间隔线
@property (nonatomic, assign) BOOL showMidLine;


//自定义布局  count：选项卡数 left：左边距 midSpaceSize：cell之间距离 cellWidth：cell宽度 lineWidth:下横线宽 lineHigth：下横线高 lineColor:颜色
- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count left:(CGFloat)left midSpaceSize:(CGFloat)midSpaceSize cellWidth:(CGFloat)cellWidth lineWidth:(CGFloat)lineWidth lineHigth:(CGFloat)lineHigth lineColor:(UIColor *)lineColor;

//平均布局   count：选项卡数 lineWidth:下横线宽 lineHigth：下横线高 lineColor:颜色
- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count lineWidth:(CGFloat)lineWidth lineHigth:(CGFloat)lineHigth lineColor:(UIColor *)lineColor;

//刷新collection
- (void)reloadCollectionData;
@end

NS_ASSUME_NONNULL_END
