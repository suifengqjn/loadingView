//
//  MaterialLoadingView.m
//  CommonUI
//
//  Created by Max on 15/11/2.
//  Copyright © 2015年 ZhangRyou. All rights reserved.
//

#import "MaterialLoadingView.h"
#import "UIColor+Hex.h"

static NSString *kYLRingStrokeAnimationKey = @"materialdesignspinner.stroke";
static NSString *kYLRingRotationAnimationKey = @"materialdesignspinner.rotation";

#define MAX_LOADING_RADIUS  20.0

@interface MaterialLoadingView () {
@private
    BOOL                    _isAnimating;
    CGPoint                 _offset;
    CAMediaTimingFunction   *_timingFunction;
    CAShapeLayer            *_progressLayer;
}
@end

@implementation MaterialLoadingView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [self initialize];
}

- (void)initialize {
    _progressLayer = [CAShapeLayer new];
    _progressLayer.strokeColor = [UIColor colorWithHexString:@"#a4a4a4" alpha:1.0].CGColor;
    _progressLayer.fillColor = nil;
    _progressLayer.lineWidth = 2.0f;
    _offset = CGPointZero;
    
    [self.layer addSublayer:_progressLayer];
    [self setBackgroundColor:[UIColor clearColor]];
    
    _timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updatePath];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    _progressLayer.strokeColor = self.tintColor.CGColor;
}

- (void)play{
    if (_isAnimating)
        return;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 1.f;
    animation.fromValue = @(0.f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    animation.removedOnCompletion = NO;
    [_progressLayer addAnimation:animation forKey:kYLRingRotationAnimationKey];
    
    CABasicAnimation *headAnimation = [CABasicAnimation animation];
    headAnimation.keyPath = @"strokeStart";
    headAnimation.duration = 1.f;
    headAnimation.fromValue = @(0.f);
    headAnimation.toValue = @(0.25f);
    headAnimation.timingFunction = _timingFunction;
    
    CABasicAnimation *tailAnimation = [CABasicAnimation animation];
    tailAnimation.keyPath = @"strokeEnd";
    tailAnimation.duration = 1.f;
    tailAnimation.fromValue = @(0.f);
    tailAnimation.toValue = @(1.f);
    tailAnimation.timingFunction = _timingFunction;
    
    
    CABasicAnimation *endHeadAnimation = [CABasicAnimation animation];
    endHeadAnimation.keyPath = @"strokeStart";
    endHeadAnimation.beginTime = 1.f;
    endHeadAnimation.duration = 0.5f;
    endHeadAnimation.fromValue = @(0.25f);
    endHeadAnimation.toValue = @(1.f);
    endHeadAnimation.timingFunction = _timingFunction;
    
    CABasicAnimation *endTailAnimation = [CABasicAnimation animation];
    endTailAnimation.keyPath = @"strokeEnd";
    endTailAnimation.beginTime = 1.f;
    endTailAnimation.duration = 0.5f;
    endTailAnimation.fromValue = @(1.f);
    endTailAnimation.toValue = @(1.f);
    endTailAnimation.timingFunction = _timingFunction;
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    [animations setDuration:2.5f];
    [animations setAnimations:@[headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]];
    animations.repeatCount = INFINITY;
    animations.removedOnCompletion = NO;
    [_progressLayer addAnimation:animations forKey:kYLRingStrokeAnimationKey];
    
    _isAnimating = true;
}

- (void)stop{
    if (!_isAnimating)
        return;
    [_progressLayer removeAnimationForKey:kYLRingRotationAnimationKey];
    [_progressLayer removeAnimationForKey:kYLRingStrokeAnimationKey];
    _isAnimating = false;
}

#pragma mark Properties
- (MaterialLoadingView * (^)(CGPoint))offset {
    return ^(CGPoint offset) {
        _offset = offset;
        [self updatePath];
        return self;
    };
}

- (MaterialLoadingView * (^)(UIColor *))maskColor {
    return  ^(UIColor * color){
        [self setBackgroundColor:color];
        return self;
    };
}

- (MaterialLoadingView * (^)(CAMediaTimingFunction *))timingFunction {
    return  ^(CAMediaTimingFunction * timefuc){
        _timingFunction = timefuc;
        return self;
    };
}

- (MaterialLoadingView * (^)(UIColor *))color {
    return  ^(UIColor * color){
        _progressLayer.strokeColor = color.CGColor;
        return self;
    };
}

- (MaterialLoadingView * (^)(CGFloat))lineWidth {
    return ^(CGFloat lineWidth){
        _progressLayer.lineWidth = lineWidth;
        [self updatePath];
        return self;
    };
}

#pragma mark - Private
- (void)updatePath {
    [_progressLayer setFrame:CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height)];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds) + _offset.x, CGRectGetMidY(self.bounds) + _offset.y);
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - _progressLayer.lineWidth / 2;
    if (radius > MAX_LOADING_RADIUS) {
        radius = MAX_LOADING_RADIUS;
    }
    CGFloat startAngle = (CGFloat)(0);
    CGFloat endAngle = (CGFloat)(2 * M_PI);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:YES];
    
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeStart = 0.f;
    _progressLayer.strokeEnd = 0.f;
}
@end
