//
//  UILabel+Badge.h
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TPLBadgeView : UIView

@end

@interface UILabel (Badge)

@property (nonatomic, strong) NSNumber *redCount;

@end

NS_ASSUME_NONNULL_END
