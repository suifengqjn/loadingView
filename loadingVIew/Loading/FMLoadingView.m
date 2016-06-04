//
//  FMLoadingView.m
//  loadingVIew
//
//  Created by qianjn on 16/6/4.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "FMLoadingView.h"
#import "UIColor+Hex.h"
@implementation FMLoadingView
+ (MaterialLoadingView *)loadingView {
    MaterialLoadingView *loadingView = [MaterialLoadingView new];
    loadingView.color([UIColor colorWithRGB:0xff8830 alpha:1]);
    [loadingView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
    [loadingView.layer setCornerRadius:4.0];
    [loadingView.layer setMasksToBounds:YES];
    [loadingView setFrame:CGRectMake(0, 0, 100, 100)];
    return loadingView;
}

@end
