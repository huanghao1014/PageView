//
//  YIDOrderListTopBarCell.h
//  OneCarDriver
//
//  Created by zhouwei on 2018/7/26.
//  Copyright © 2018年 yirenyiche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YIDOrderListTopBarCell : UICollectionViewCell

- (void)reloadDataTopButtonWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath changeIndex:(NSInteger)changeindex;

@end
