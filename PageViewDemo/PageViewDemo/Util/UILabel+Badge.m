//
//  UILabel+Badge.m
//  PageViewDemo
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UILabel+Badge.h"
#import <objc/runtime.h>
@class BadgeView;

static char const *redCountProperty = "redCountProperty";

@implementation TPLBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end

@implementation UILabel (Badge)
@dynamic redCount;

- (void)setRedCount:(NSNumber *)redCount{
    objc_setAssociatedObject(self, redCountProperty, redCount, OBJC_ASSOCIATION_RETAIN);
    for (TPLBadgeView *subView in self.subviews) {
        if ([subView isKindOfClass:[TPLBadgeView class]]) {
            [subView removeFromSuperview];
        }
    }
    if ([redCount integerValue] > 0) {
        CGSize labelSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
        CGSize size =  [self.text   boundingRectWithSize:labelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:@{NSFontAttributeName:self.font} context:nil].size;
        self.numberOfLines = 1;
        TPLBadgeView *redCircleView = [TPLBadgeView new];
        redCircleView.backgroundColor=[UIColor redColor];
        [self layoutIfNeeded];
        CGFloat redX = (self.bounds.size.width - size.width)/2 + size.width;
        CGFloat redY = (self.bounds.size.height - size.height)/2 - 4;
        redCircleView.frame = CGRectMake(redX, redY, 8, 8);
        redCircleView.layer.cornerRadius  = 4.f;
        redCircleView.layer.masksToBounds = YES;
        [self addSubview:redCircleView];
    }
}

- (NSNumber *)redCount{
    return objc_getAssociatedObject(self, redCountProperty);
}

@end




