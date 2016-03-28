//
//  ViewController.m
//  拖拽排序的实现
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 汤威. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Ex.h"
#import "PullLabel.h"

static const int col = 3;
const CGFloat margin = 15;

@interface ViewController ()<PullLabelDelegate>
@property (nonatomic,weak) UIView *container;
@property (nonatomic,strong) PullLabel *intersectLabel;
@property (nonatomic,strong) PullLabel *selectlabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUp];
}

- (void)setUp
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(20, 100, self.view.width - 40, 250)];
    container.backgroundColor = [UIColor blackColor];
    [self.view addSubview:container];
    self.container = container;
    
    for (int i = 0;i< 8; i++) {
        PullLabel *label = [[PullLabel alloc] init];
        label.backgroundColor = [UIColor redColor];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.width = 60;
        label.height = 40;
        label.x = margin + (i%col) * ((self.container.width - 2 * margin - col * label.width)/(col -1)) + (i%3) * label.width;
        label.y = margin + (i/col) * ((self.container.width - 2 * margin - col * label.width)/(col -1)) + (i/3) * label.height;
        label.delegate = self;
        [self.container addSubview:label];
    }
}

- (void)PullLabelBeginMove:(PullLabel *)pullLabel
{
    NSArray *subViews = self.container.subviews;
    
    self.selectlabel = pullLabel;
    BOOL intersect;
    for (int i = 0; i<subViews.count; i++) {
        PullLabel *label = subViews[i];
        if (pullLabel == label) continue;
        if (CGRectIntersectsRect(pullLabel.frame, label.frame)) {
            if (self.intersectLabel == label) return;
            self.intersectLabel = label;
            
            intersect = YES;
            NSUInteger labelIndex = [subViews indexOfObject:label];
            NSUInteger pulllabelIndex = [subViews indexOfObject:pullLabel];
            
            // 此处是将拖拽的控件插入到指定位置的前面和后面
            if (labelIndex < pulllabelIndex) {
                [pullLabel.superview insertSubview:pullLabel belowSubview:label];
            }else {
                [pullLabel.superview insertSubview:pullLabel aboveSubview:label];
            }
            [self updateFrame];
            return;
        }
    }
    if (intersect) self.intersectLabel = nil;
}

- (void)PullLabelChange:(PullLabel *)pullLabel
{
    [self PullLabelBeginMove:pullLabel];
}

- (void)PullLabelCancleMove:(PullLabel *)pullLabel
{
    self.intersectLabel = nil;
    self.selectlabel = nil;
    [self updateFrame];
}

- (void)updateFrame
{
    NSArray *subviews = self.container.subviews;
    
    [UIView animateWithDuration:0.25 animations:^{
        for (int i = 0;i<subviews.count;i++) {
            PullLabel *label = subviews[i];
            if (label == self.selectlabel) {
                continue;
            }
            // 此处计算冗余。应该把之前计算的保存起来，这里直接用。
            label.x = margin + (i%col) * ((self.container.width - 2 * margin - col * label.width)/(col -1)) + (i%3) * label.width;
            label.y = margin + (i/col) * ((self.container.width - 2 * margin - col * label.width)/(col -1)) + (i/3) * label.height;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
