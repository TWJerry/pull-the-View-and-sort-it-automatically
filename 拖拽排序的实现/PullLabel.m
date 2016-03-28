//
//  PullLabel.m
//  拖拽排序的实现
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 汤威. All rights reserved.
//

#import "PullLabel.h"
#import "UIView+Ex.h"
@implementation PullLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pull:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)pull:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self pullLabelBeginMove:recognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self pullLabelChanging:recognizer];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            [self pullLabelStopMove:recognizer];
            break;
        default:
            break;
    }
}

- (void)pullLabelBeginMove:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    self.x += point.x;
    self.y += point.y;
    [pan setTranslation:CGPointZero inView:pan.view];
    if ([self.delegate respondsToSelector:@selector(PullLabelBeginMove:)]) {
        [self.delegate PullLabelBeginMove:self];
    }
}

- (void)pullLabelChanging:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    self.x += point.x;
    self.y += point.y;
    [pan setTranslation:CGPointZero inView:pan.view];
    
    if ([self.delegate respondsToSelector:@selector(PullLabelChange:)]) {
        [self.delegate PullLabelChange:self];
    }
}

- (void)pullLabelStopMove:(UIPanGestureRecognizer *)pan
{
    if ([self.delegate respondsToSelector:@selector(PullLabelCancleMove:)]) {
        [self.delegate PullLabelCancleMove:self];
    }
}
@end
