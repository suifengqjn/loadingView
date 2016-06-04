//
//  ViewController.m
//  loadingVIew
//
//  Created by qianjn on 16/6/4.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "ViewController.h"
#import "FMLoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.view showLoadingView:[FMLoadingView loadingView]];  //默认可交互
    
    [self.view showLoadingView:[FMLoadingView loadingView] isDisabelTouch:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view hideLoadingView];
}

@end
