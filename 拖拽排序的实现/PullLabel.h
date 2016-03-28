//
//  PullLabel.h
//  拖拽排序的实现
//
//  Created by mac on 15/6/24.
//  Copyright (c) 2015年 汤威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PullLabel;

@protocol PullLabelDelegate <NSObject>

- (void)PullLabelBeginMove:(PullLabel *)pullLabel;
- (void)PullLabelChange:(PullLabel *)pullLabel;
- (void)PullLabelCancleMove:(PullLabel *)pullLabel;

@end

@interface PullLabel : UILabel
@property (nonatomic,assign) id<PullLabelDelegate> delegate;
@end
