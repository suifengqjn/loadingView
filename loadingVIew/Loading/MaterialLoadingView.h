//
//  MaterialLoadingView.h
//  CommonUI
//
//  Created by Max on 15/11/2.
//  Copyright © 2015年 ZhangRyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Loading.h"

@interface MaterialLoadingView : UIView<ILoadingView>

@property (nonatomic, readonly) BOOL isAnimating;

- (MaterialLoadingView * (^)(CGPoint))offset;
- (MaterialLoadingView * (^)(UIColor *))color;
- (MaterialLoadingView * (^)(UIColor *))maskColor;
- (MaterialLoadingView * (^)(CGFloat))lineWidth;
- (MaterialLoadingView * (^)(CAMediaTimingFunction *))timingFunction;

- (void)play;
- (void)stop;
@end
