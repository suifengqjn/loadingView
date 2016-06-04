//
//  UIView+Loading.m
//  CommonUI
//
//  Created by ZhangRyou on 2/20/15.
//  Copyright (c) 2015 ZhangRyou. All rights reserved.
//

#import "UIView+Loading.h"

@implementation UIView(Loading)
- (void)showLoadingView:(UIView<ILoadingView> *)loadingView {
    [self showLoadingView:loadingView isDisabelTouch:NO];
}

- (void)showLoadingView:(UIView<ILoadingView> *)loadingView isDisabelTouch:(BOOL)isDisable {
    if ([loadingView respondsToSelector:@selector(play)]) {
        [loadingView performSelector:@selector(play)];
    }
    if (isDisable && [[UIApplication sharedApplication] isIgnoringInteractionEvents] == NO) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    CGPoint centerPoint = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    [self addSubview:loadingView];
    [loadingView setCenter:centerPoint];
    [loadingView setAlpha:0.0];
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [loadingView setAlpha:1.0];
                     } completion:^(BOOL finished) {
                     }];
}

- (void)hideLoadingView {
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
    for (UIView *itemView in [self subviews]) {
        if ([itemView conformsToProtocol:@protocol(ILoadingView)]) {
            if ([itemView respondsToSelector:@selector(stop)]) {
                [itemView performSelector:@selector(stop)];
            }
            [itemView removeFromSuperview];
        }
    }
}
@end
