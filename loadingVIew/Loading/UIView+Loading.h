//
//  UIView+Loading.h
//  CommonUI
//
//  Created by ZhangRyou on 2/20/15.
//  Copyright (c) 2015 ZhangRyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ILoadingView<NSObject>
@optional
- (void)play;
- (void)stop;
@end


@interface UIView(Loading)
- (void)showLoadingView:(UIView<ILoadingView> *)loadingView isDisabelTouch:(BOOL)isDisable;
- (void)showLoadingView:(UIView<ILoadingView> *)loadingView;
- (void)hideLoadingView;
@end
