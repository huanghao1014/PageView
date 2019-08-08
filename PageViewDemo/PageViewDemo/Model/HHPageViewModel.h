//
//  TPLPageViewModel.h
//  PageViewDemo
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPageViewModel : NSObject
//未读数量
@property (nonatomic, assign)  NSNumber *count;
//项目名称
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
